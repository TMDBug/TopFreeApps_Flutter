import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomepageState();
  }
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
