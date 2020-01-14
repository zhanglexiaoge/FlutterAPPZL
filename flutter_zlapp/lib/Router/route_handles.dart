import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zlapp/Page/detailPage/detailPage.dart';
import 'package:flutter_zlapp/Page/splashPage/splashPage.dart';
import 'package:flutter_zlapp/Page/Login/login.dart';
import 'package:flutter_zlapp/Tabar/tabar.dart';


// splash 页面 广告页
var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return SplashPage();
    });

// 登录页
var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return LoginView();
    });
// 跳转到主页
var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return TabarWidget();
    });

// 跳转到详情页
var detailHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      String message = params["message"]?.first;
      String result = params["result"]?.first;
      Color color = Color(0xFFFFFFFF);
      return DetailPage(message: message,color: color,result: result);
    });