import 'package:flutter/material.dart';
import 'package:flutter_zlapp/Tool/Utils.dart';
class CustomMenusView extends StatefulWidget {
   final String iconData;
   final String title;
   final GestureTapCallback onTap;
   const CustomMenusView({Key key,this.iconData,this.title,this.onTap}):super(key:key);
  @override
  _CustomMenusViewState createState() {
    return _CustomMenusViewState();
  }
}

class _CustomMenusViewState extends State<CustomMenusView> {
  @override
  Widget build(BuildContext context) {
   double width = (Utils.width - 30 *3 - 15 * 2) / 3;
   //double height = width * 383 / 270;


    return GestureDetector(
      onTap: this.widget.onTap,
      child: Column(
        children: <Widget>[
          Image.asset(this.widget.iconData,height: width,width: width),
           Text(this.widget.title == null ? "" : this.widget.title, style: TextStyle(fontSize: 14.0, color: Colors.black),),
        ],
      ),
    );
  }
}