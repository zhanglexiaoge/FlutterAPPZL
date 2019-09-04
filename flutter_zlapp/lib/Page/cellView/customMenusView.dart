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
    return GestureDetector(
      onTap: this.widget.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(this.widget.iconData,height: 40,width: 40),
            SizedBox(height: 8.0),
            Text(this.widget.title == null ? "" : this.widget.title, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold,color: Colors.black)),
          ],
        ),
      ),
    );
  }
}