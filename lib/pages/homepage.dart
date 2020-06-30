import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:topFreeApp/pages/detail_page.dart';

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State<Homepage>
    with AutomaticKeepAliveClientMixin {
  List _bannerDataList = List();
  List _dataList = List();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('-------------home init State-----------');
    if (_dataList.length == 0) {
      this._getDatas();
    }
  }

  _getDatas() async {
    Dio dio = Dio();
    Response res = await dio.get(
        'https://itunes.apple.com/cn/rss/topfreeapplications/limit=100/json');
    if (res.statusCode == 200) {
      // print(jsonDecode(res.data));
      setState(() {
        _dataList = jsonDecode(res.data)['feed']['entry'];

        _bannerDataList.add(_dataList[0]);
        _bannerDataList.add(_dataList[1]);
        _bannerDataList.add(_dataList[2]);

        _dataList.removeRange(0, 3);
      });
    } else {
      print('Error Code:${res.statusCode}');
    }
  }

  // 列表
  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(_dataList[index]['im:image'][1]['label']),
        ),
        trailing: Text(
          '${index + _bannerDataList.length + 1}',
          style: TextStyle(
              color: Color.fromRGBO(
                  255, 11, 11, (_dataList.length - index) * 0.01)),
        ),
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tops',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
      ),
      body: _dataList.length == 0
          ? Center(
              child: Text(
              '加载中...',
              style: TextStyle(fontSize: 16),
            ))
          : CustomScrollView(
              slivers: <Widget>[
                // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
                SliverToBoxAdapter(
                  child: Container(
                    height: 150,
                    color: Color.fromRGBO(0, 192, 215, 1),
                    child: Swiper(
                      itemCount: _bannerDataList.length, // 滚动图片的数量
                      autoplay: true, // 自动播放
                      pagination: SwiperPagination(
                        alignment: Alignment.bottomRight, // 对齐方式
                        margin: EdgeInsets.fromLTRB(0, 0, 14, 10), // 边距
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        // 构造器
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                        appIterm: _bannerDataList[index])));

                            // CommonModel model = bannerList[index];
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => WebView(
                            //       url: model.url,
                            //     ),
                            //   ),
                            // );
                          },
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: Center(
                                        child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                          _bannerDataList[index]['im:image'][1]
                                              ['label']),
                                    ))),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          _bannerDataList[index]['im:name']
                                              ['label'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          '[${_bannerDataList[index]['category']['attributes']['label']}]',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  212, 213, 216, 1)),
                                        ),
                                        Text(
                                          _bannerDataList[index]['im:artist']
                                              ['label'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        'Top ${index + 1}',
                                        style: TextStyle(
                                            color: Colors.amberAccent,
                                            fontSize: 20),
                                      ),
                                    ))
                              ],
                            ),
                            //设置背景图片
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.5),
                                // fit: BoxFit.cover,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(_bannerDataList[index]
                                        ['im:image'][1]['label']),
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(.8),
                                        BlendMode.multiply))),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate(_buildListItem,
                        childCount: _dataList.length),
                    itemExtent: 75.0)
              ],
            ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(
    //       'Homepage',
    //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    //     ),
    //   ),
    //   body: this._dataList.length == 0
    //       ? Center(
    //           child: Text(
    //             '加载中...',
    //             style: TextStyle(fontSize: 16),
    //           ),
    //         )
    //       : ListView.builder(
    //           itemCount: _dataList.length,
    //           itemBuilder: (BuildContext context, int index) {
    //             return Container(
    //               child: ListTile(
    //                 leading:
    //                     Image.network(_dataList[index]['im:image'][1]['label']),
    //                 title: Text(
    //                   _dataList[index]['im:name']['label'],
    //                   style: TextStyle(color: Color.fromRGBO(31, 86, 30, 1)),
    //                 ),
    //                 subtitle: Text(
    //                   _dataList[index]['category']['attributes']['label'],
    //                   style: TextStyle(color: Color.fromRGBO(142, 133, 16, 1)),
    //                 ),
    //                 onTap: () => _tapRowWithData(context, index),
    //               ),
    //               decoration: BoxDecoration(
    //                   border: Border(
    //                       bottom:
    //                           BorderSide(width: 1, color: Color(0xffe5e5e5))),
    //                   color: Colors.white),
    //             );
    //           },
    //         ),
    // );
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
}
