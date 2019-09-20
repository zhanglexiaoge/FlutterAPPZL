import 'package:flutter/material.dart';

class UpdateView extends StatefulWidget {
   final String iconPath;
   final String title;
   const UpdateView({Key key,this.iconPath,this.title}):super(key:key);
  @override
  _UpdateViewState createState() {
    return _UpdateViewState();
  }
}

class _UpdateViewState extends State<UpdateView> {
  @override
  Widget build(BuildContext context) {
    return Row (
            children: <Widget>[
              Image.asset(this.widget.iconPath,height: 14,width: 14,),
              Container(
                 height: 14.0,
                 width: 5.0,
              ),
              Text(this.widget.title,style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold,color: Colors.black)),
            ],
          );
   }
}