import 'package:flutter/material.dart';

import 'package:topFreeApp/pages/commons/bottom_navigation_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homepage',
      theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Color.fromRGBO(0, 110, 84, 1)),
      home: BottomNavigationBarWidget(),
    );
  }
}
