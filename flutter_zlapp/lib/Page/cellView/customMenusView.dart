import 'package:flutter/material.dart';
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
    return GestureDetector(
      onTap: this.widget.onTap,
      child: Column(
        children: <Widget>[
          Image.asset(this.widget.iconData,height: 50,width: 50,),
           Text(this.widget.title == null ? "" : this.widget.title, style: TextStyle(fontSize: 14.0, color: Colors.black),),
        ],
      ),
    );
  }
}