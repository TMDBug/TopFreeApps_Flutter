import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomepageState();
  }

  // var a = _getDatas();
}

class _HomepageState extends State {
  List _dataList = List();

  @override
  void initState() {
    super.initState();
    this._getDatas();
  }

  _getDatas() async {
    Dio dio = new Dio();
    Response res = await dio.get(
        'https://itunes.apple.com/cn/rss/topfreeapplications/limit=100/json');
    if (res.statusCode == 200) {
      // print(jsonDecode(res.data));
      setState(() {
        _dataList = jsonDecode(res.data)['feed']['entry'];
      });
    } else {
      print('Error Code:${res.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: ListView.builder(
        itemCount: _dataList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Image.network(_dataList[index]['im:image'][0]['label']),
            title: Text(_dataList[index]['im:name']['label']),
            subtitle: Text(_dataList[index]['category']['attributes']['label']),
          );
        },
      ),
    );
  }
}
