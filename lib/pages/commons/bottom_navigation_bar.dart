import 'package:flutter/material.dart';

import 'package:topFreeApp/pages/homepage.dart';
import 'package:topFreeApp/pages/tops_page.dart';
import 'package:topFreeApp/pages/search_page.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomNavigationBarState();
  }
}

class _BottomNavigationBarState extends State<BottomNavigationBarWidget> {
  int _currentIndex = 0;
  final List<Widget> _pagesDataList = [Homepage(), TopsPage(), SearchPage()];

  final pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  void onTap(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: _pagesDataList,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(), // 禁止滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _getNavigationBars(),
        currentIndex: _currentIndex,
        onTap: onTap,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Color.fromRGBO(0, 110, 87, 1),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: _getNavigationBars(),
      //   currentIndex: _currentIndex,
      //   type: BottomNavigationBarType.fixed,
      //   onTap: (int index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.grey,
      //   backgroundColor: Color.fromRGBO(0, 110, 87, 1),
      // )
    );
  }
}

List _getNavigationBars() {
  List<BottomNavigationBarItem> navigationBarList = List();
  BottomNavigationBarItem homepage = BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        // color: Colors.black87,
      ),
      title: Text(
        'Home',
        // style: TextStyle(color: Colors.black87),
      ));
  BottomNavigationBarItem topsPage = BottomNavigationBarItem(
      icon: Icon(
        Icons.trending_up,
        // color: Colors.lightBlue,
      ),
      title: Text(
        'Tops',
        // style: TextStyle(color: Colors.lightBlue),
      ));
  BottomNavigationBarItem searchPage = BottomNavigationBarItem(
      icon: Icon(
        Icons.search,
        // color: Colors.lightBlue,
      ),
      title: Text(
        'Search',
        // style: TextStyle(color: Colors.lightBlue),
      ));
  navigationBarList..add(homepage)..add(topsPage)..add(searchPage);
  return navigationBarList;
}
