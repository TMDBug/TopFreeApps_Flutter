import 'package:flutter/material.dart';

import 'package:topFreeApp/pages/commons/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: SearchBar(
        onSearch: (value) {
          print('$value');
          return '';
        },
      ),
      body: Center(
        // child: Text(
        //   '- Empty -',
        //   style: TextStyle(
        //       color: Color.fromRGBO(188, 188, 188, 1),
        //       fontWeight: FontWeight.w200),
        // ),
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(Icons.search),
              title: Text('APP序号： $index'),
              subtitle: Text('多思考组件的合并 形成新的组件'),
            );
          },
        ),
      ),
    );
  }
}
