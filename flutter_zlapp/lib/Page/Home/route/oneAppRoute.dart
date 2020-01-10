///oneAPP 路由管理

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_zlapp/Page/Home/detailsPage/detailsPage.dart';

///配置路由
final routes = {
  '/detailsPage': (context, {arguments}) => DetailsPage(
    arguments: arguments,
  ),
};
///统一处理路由跳转传参
Function oneAppRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = CupertinoPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
      CupertinoPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return null;
};