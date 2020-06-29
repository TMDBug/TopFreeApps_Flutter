import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Map appIterm;
  DetailPage({Key key, @required this.appIterm}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState();
  }
}

class _DetailPageState extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Text('data'),
    );
  }
}
