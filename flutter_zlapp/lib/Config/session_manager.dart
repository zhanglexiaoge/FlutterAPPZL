import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter_zlapp/Config/serviceUrl.dart';

class SessionManager extends Dio {

  static const String CONTENT_TYPE_PRIMARY = "application";
  //static const String CONTENT_TYPE_FORM = "x-www-form-urlencoded"; // MediaType.parse("application/json; charset=UTF-8");
  static const String CONTENT_TYPE_JSON = "json";
  static const String CONTENT_CHART_SET = 'utf-8';

  // 工厂模式
  factory SessionManager() =>_getInstance();
  static SessionManager get instance => _getInstance();
  static SessionManager _instance;
  SessionManager._internal() {
    // 初始化
  }
  //设置header
  static SessionManager _getInstance() {
    if (_instance == null) {
      _instance =  SessionManager._internal();
      // Map<String, dynamic> headers;
      // headers['HC-ACCESS-TOKEN'] = 'czo1OToiYmI2NFRrbDdLelpKM2ZLTXZVZWdWU0N1NFVaV1U1dU03Z2luQ0VPc1VpakFYeERjYmFOdFliR2hlV0EiOw==';
       BaseOptions options = BaseOptions(
        // 15s 超时时间
          connectTimeout:15000,
          receiveTimeout:15000,
          responseType: ResponseType.json,
          contentType: ContentType(CONTENT_TYPE_PRIMARY, CONTENT_TYPE_JSON,charset: CONTENT_CHART_SET),
          //headers: headers,
          //baseUrl: BaseserviceUrl,
      );
      _instance.options = options;
    }
    return _instance;
  }
}