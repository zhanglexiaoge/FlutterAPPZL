import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin  {
  //保持状态
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return new  MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('我的'),
        ),
      ),
    );
  }
}