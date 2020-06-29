import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Map appIterm;
  DetailPage({Key key, @required this.appIterm}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState(appInfo: appIterm);
  }
}

class _DetailPageState extends State<DetailPage> {
  final Map appInfo;
  _DetailPageState({Key key, @required this.appInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          this.appInfo['im:name']['label'],
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
        )),
        body: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver: new SliverList(
                delegate: new SliverChildListDelegate(
                  <Widget>[
                    Center(
                        child: Image.network(appInfo['im:image'][2]['label'])),
                    Container(
                      height: 15,
                    ),
                    Center(
                      child: Row(
                        children: <Widget>[
                          Text(appInfo['im:name']['label'],
                              style: TextStyle(fontSize: 15)),
                          Text(
                              ' - [${appInfo['category']['attributes']['label']}]',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue))
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                    Container(
                      height: 15,
                    ),
                    Center(
                        child: Text('From: ${appInfo['rights']['label']}',
                            style:
                                TextStyle(fontSize: 14, color: Colors.orange))),
                    Container(
                      height: 15,
                    ),
                    Center(
                        child: Text('${appInfo['summary']['label']}',
                            style: TextStyle(
                              fontSize: 14,
                            ))),
                    Container(
                      height: 15,
                    ),
                    RaisedButton(
                        onPressed: () {
                          Navigator.pop(context,
                              '刚刚浏览了：${this.appInfo['im:name']['label']}');
                        },
                        child: Text('返回'),
                        color: Colors.purple)
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
