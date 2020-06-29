import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:topFreeApp/pages/detail_page.dart';

class TopsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TopsPageState();
  }
}

class _TopsPageState extends State<TopsPage>
    with AutomaticKeepAliveClientMixin {
  List _dataList = List();

  @override
  void initState() {
    super.initState();
    print('----- tops page init----');

    this._getDatas();
  }

  _getDatas() async {
    Dio dio = new Dio();
    Response res = await dio.get(
        'https://itunes.apple.com/us/rss/topfreeapplications/limit=100/json');
    if (res.statusCode == 200) {
      // print(jsonDecode(res.data));
      setState(() {
        _dataList = jsonDecode(res.data)['feed']['entry'];
      });
    } else {
      print('Error Code:${res.statusCode}');
    }
  }

  // 列表项
  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      child: ListTile(
        leading: Image.network(_dataList[index]['im:image'][1]['label']),
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
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xffe5e5e5))),
          color: Colors.white),
    );
  }

  //异步处理
  _tapRowWithData(BuildContext context, int index) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(appIterm: _dataList[index])));
    if (null != result) {
      //第一页面提示返回过来的值
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('$result')));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tops'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
          SliverToBoxAdapter(
            child: Container(
              height: 150,
              color: Colors.green,
              child: Text('HeaderView'),
            ),
          ),
          // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
          _dataList.length == 0
              ? Text(
                  '加载中...',
                  style: TextStyle(fontSize: 16),
                )
              : SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(_buildListItem,
                      childCount: _dataList.length),
                  itemExtent: 75.0)
        ],
      ),
    );
  }

  @override
  get wantKeepAlive => true;
}
