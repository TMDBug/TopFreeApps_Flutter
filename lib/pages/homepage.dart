import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomepageState();
  }

  List a = _getDatas();
}

class _HomepageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: Text('home'),
      ),
    );
  }
}

_getDatas() async {
  List dataList = List();

  Dio dio = new Dio();
  Response res = await dio.get(
      'https://itunes.apple.com/cn/rss/topfreeapplications/limit=100/json');
  print(res.data.toString());
  return dataList;
}
