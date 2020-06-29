import 'package:flutter/material.dart';

class TopsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TopsPageState();
  }
}

class _TopsPageState extends State<TopsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    print('----- tops page init----');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tops'),
      ),
      body: Center(
        child: Text('TopsPage'),
      ),
    );
  }

  @override
  get wantKeepAlive => true;
}
