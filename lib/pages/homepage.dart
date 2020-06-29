import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomepageState();
  }
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
      body: this._dataList.length == 0
          ? Center(
              child: Text(
                '加载中...',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: _dataList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: ListTile(
                    leading:
                        Image.network(_dataList[index]['im:image'][1]['label']),
                    title: Text(
                      _dataList[index]['im:name']['label'],
                      style: TextStyle(color: Color.fromRGBO(31, 86, 30, 1)),
                    ),
                    subtitle: Text(
                      _dataList[index]['category']['attributes']['label'],
                      style: TextStyle(color: Color.fromRGBO(142, 133, 16, 1)),
                    ),
                    onTap: () => _tapRowWithData(context, index),
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: Color(0xffe5e5e5))),
                      color: Colors.white),
                );
              },
            ),
    );
  }

  //异步处理
  _tapRowWithData(BuildContext context, int index) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ProductDetailPage(appIterm: _dataList[index])));
    if (null != result) {
      //第一页面提示返回过来的值
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('$result')));
    }
  }
}

class ProductDetailPage extends StatelessWidget {
  final Map appIterm;
  ProductDetailPage({Key key, @required this.appIterm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appIterm['im:name']['label'])),
      body: Column(
        children: <Widget>[
          Container(
            height: 15,
          ),
          Center(child: Image.network(appIterm['im:image'][2]['label'])),
          Container(
            height: 15,
          ),
          Center(
              child: Text(appIterm['title']['label'],
                  style: TextStyle(fontSize: 15))),
          Container(
            height: 15,
          ),
          Container(
            height: 15,
          ),
          RaisedButton(
              onPressed: () {
                Navigator.pop(context, 'product.description');
              },
              child: Text('返回'),
              color: Colors.purple)
        ],
      ),
    );
  }
}
