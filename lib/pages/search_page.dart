import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: SearchBar(
        onSearch: (value) {
          print('$value');
          _dataList.add('$value');
          setState(() {});
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
                    leading: Icon(Icons.search),
                    title: Text('APP序号： $index, ${_dataList[index]}'),
                    subtitle: Text('多思考组件的合并 形成新的组件'),
                  );
                },
              ),
      ),
    );
  }
}
