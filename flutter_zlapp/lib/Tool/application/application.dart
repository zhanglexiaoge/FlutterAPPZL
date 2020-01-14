import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Application{

  static SharedPreferences spstance;
  static double screenWidth;
  static double screenHeight;
  static double statusBarHeight;
  static double bottomBarHeight;
  static initSp() async{
    spstance = await SharedPreferences.getInstance();
  }



}