import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationPage extends StatefulWidget {
  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> with AutomaticKeepAliveClientMixin  {
  //保持状态
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('haha'),
    );
  }
 }