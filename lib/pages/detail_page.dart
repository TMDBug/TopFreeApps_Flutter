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
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
      )),
      body: Column(
        children: <Widget>[
          Container(
            height: 15,
          ),
          Center(child: Image.network(appInfo['im:image'][2]['label'])),
          Container(
            height: 15,
          ),
          Center(
              child: Text(appInfo['title']['label'],
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
