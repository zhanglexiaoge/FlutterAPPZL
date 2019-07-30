import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new  MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('首页'),
        ),
      ),
    );
  }
}