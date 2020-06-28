import 'package:flutter/material.dart';

class TopsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TopsPageState();
  }
}

class _TopsPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tops'),
      ),
      body: Center(
        child: Text('TopsPage'),
      ),
    );
  }
}
