import 'package:flutter/material.dart';
import 'Tabar/tabar.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const String _title = 'Flutter Code Sample';
    return MaterialApp(
      title: _title,
      home: TabarWidget(),
    );
  }
}

