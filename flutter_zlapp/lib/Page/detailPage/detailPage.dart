import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class DetailPage extends StatefulWidget {
  final String message;
  final Color color;
  final String result;
  DetailPage({Key key, this.message, this.color,this.result}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('message >>>> ' + widget.message);
    print('color >>>> ' + widget.color.toString());
    print('result >>>> ' + widget.result);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('详情页'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context,widget.result);
            }),
      ),
    );
  }
}
