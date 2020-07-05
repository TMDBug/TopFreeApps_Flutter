import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:topFreeApp/pages/commons/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List _dataList = [];

  _searchRequest(String key) async {
    Dio dio = new Dio();
    Response res = await dio.get('https://itunes.apple.com/search?term=$key');
    if (res.statusCode == 200) {
      // print(jsonDecode(res.data));
      setState(() {
        _dataList = jsonDecode(res.data)['results'];
      });
    } else {
      print('Error Code:${res.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: SearchBar(
        onSearch: (value) {
          // print('$value');
          _searchRequest(value);
          FocusScope.of(context).requestFocus(FocusNode());
          return '';
        },
      ),
      body: Center(
        child: _dataList.length == 0
            ? Text(
                '- Empty -',
                style: TextStyle(
                    color: Color.fromRGBO(188, 188, 188, 1),
                    fontWeight: FontWeight.w200),
              )
            : ListView.builder(
                itemCount: _dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading:
                        Image.network('${_dataList[index]['artworkUrl60']}'),
                    title: Text('${_dataList[index]['trackName']}'),
                    subtitle: Text('${_dataList[index]['collectionName']}'),
                  );
                },
              ),
      ),
    );
  }
}
