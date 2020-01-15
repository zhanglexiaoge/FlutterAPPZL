import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zlapp/Page/Login/login.dart';
import 'package:flutter_zlapp/Router/route_handles.dart';

class Routes {
  static String root = "/";
  static String tabbarpage = "/tabbarpage";
  static String login = "/login";
  static String detail = "/detail";
  static String facemanage = "/facemanage";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
          return LoginView();
        });
    router.define(root, handler: splashHandler);
    router.define(login, handler: loginHandler);
    router.define(tabbarpage, handler: homeHandler);
    router.define(detail, handler: detailHandler);
    router.define(facemanage, handler: facemanageHandler);
  }

}