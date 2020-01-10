import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_zlapp/Config/serviceUrl.dart';
import 'package:flutter_zlapp/Config/result_data.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
class HttpUtil {
  static const String _TAG = "网络请求";
  // ignore: non_constant_identifier_names
  final String GET = 'GET';

  // ignore: non_constant_identifier_names
  final String POST = 'POST';

  // ignore: non_constant_identifier_names
  final String PUT = 'PUT';

  /*接口请求token*/
  String token;

  /*BaseUrl 从新设置baseurl*/
  String baseUrl;

  /*设备uuid*/
  String deviceUuid;

  /*取消token*/
  CancelToken _cancelToken;

  /*网络请求对象*/
  Dio _dio;

  /*网络请求配置*/
  BaseOptions _options;


  /*单例模式*/
  factory HttpUtil() => _sharedInstance();

  static HttpUtil get instance => _sharedInstance();
  static HttpUtil _instance;

  HttpUtil._() {
    _cancelToken = CancelToken();
    _options = BaseOptions(
      /*15s 超时时间*/
      connectTimeout: 15000,
      receiveTimeout: 15000,
    );
    _dio = Dio(_options);
  }

  static HttpUtil _sharedInstance() {
    if (_instance == null) {
      _instance = HttpUtil._();
    }
    return _instance;
  }
  //customBaseUrl 自定义customBaseUrl
  /*get请求*/
  Future<Map<String, dynamic>> get(String url,
      {Map<String, dynamic> params, String customBaseUrl}) async {
    return _request(url,
        method: GET, params: params, customBaseUrl: customBaseUrl);
  }

  /*post请求*/
  Future<Map<String, dynamic>> post(String url,
      {Map<String, dynamic> params, String customBaseUrl}) async {
    return _request(url,
        method: POST, params: params, customBaseUrl: customBaseUrl);
  }

  /*put请求*/
  Future<Map<String, dynamic>> put(String url,
      {Map<String, dynamic> params, String customBaseUrl}) async {
    return _request(url,
        method: PUT, params: params, customBaseUrl: customBaseUrl);
  }

  /*上传文件*/
//  Future<String> upload(
//      File file,
//      ProgressCallback progress,
//      ) async {
//    Map<String, dynamic> qiniuMap;
//    try {
//      qiniuMap = await HttpUtil.instance.get(Urls.qiniu_token);
//    } catch (exception) {
//      DioError error = exception;
//      return Future.error(error.message);
//    }
//    if (qiniuMap != null) {
//      String postfix = file.path.split(".").last;
//      //获取token10位随机数
//      String alphabet = token ?? "";
//      int subToken = 10;
//      String left = '';
//      for (var i = 0; i < subToken; i++) {
//        left = left + alphabet[Random().nextInt(alphabet.length)];
//      }
//      String key =
//          "taskAffix/flutter-${DateTime.now().millisecondsSinceEpoch}$left.$postfix";
//      FormData formData = FormData.from({
//        "key": key,
//        "token": qiniuMap["data"]["token"],
//        "file": UploadFileInfo(file, key)
//      });
//      Response response = await _dio.post(Urls.qiniuUpladUrl,
//          data: formData, onSendProgress: progress);
//      if (response.statusCode == 200) {
//        return Future.value("${qiniuMap["data"]["domain"]}/$key");
//      } else {
//        return Future.error(response.statusMessage);
//      }
//    }
//    return Future.error("获取七牛token失败");
//  }


  /*请求部分*/
  Future<Map<String, dynamic>> _request(String url,
      {String method,
        Map<String, dynamic> params,
        String customBaseUrl}) async {
    Response response;
    try {
      _dio.options.headers["HC-ACCESS-TOKEN"] = token ??
          "czo1OToiM2Q2Y1NXRDhWMWduUWRwdXZiZ28xOWZvYW5pYlZwRlBTNmJ0U2xIeFJFNnpLK0ZKMEp1V0JwMVd6cFkiOw==";
      if (deviceUuid != null) {
        _dio.options.headers["HC-ACCESS-UUID"] = deviceUuid;
      }
      _dio.options.baseUrl = customBaseUrl ?? (baseUrl ?? BaseserviceUrl);
      if (_cancelToken.isCancelled) {
        _cancelToken = CancelToken();
      }
      if (method == GET) {
        response = await _dio.get(url,
            queryParameters: params, cancelToken: _cancelToken);
      } else if (method == POST) {
        response = await _dio.post(url,
            queryParameters: params, cancelToken: _cancelToken);
      } else if (method == PUT) {
        response = await _dio.put(url,
            queryParameters: params, cancelToken: _cancelToken);
      }

      // 打印网络日志
      StringBuffer requestParam = new StringBuffer();
      requestParam.write("$_TAG ");
      requestParam.write("Url:");
      requestParam.write(baseUrl);
      requestParam.write(url);
      requestParam.write("\n");
      requestParam.write("$_TAG ");
      requestParam.write("params:");
      requestParam.write(json.encode(params));
      printLog(requestParam.toString());
      return await handleDataSource(response, method, url: url);
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  /// 数据处理
  Future <Map<String, dynamic>> handleDataSource(Response response,String method, {String url = ""}) {
    ResultData resultData;
    String errorMsg = "";
    int statusCode;
    statusCode = response.statusCode;
    printLog("$_TAG statusCode:" + statusCode.toString());
//    if (method == Method.DOWNLOAD) {
//      if (statusCode == 200) {
//      /// 下载成功
//      resultData = ResultData('下载成功', true);
//    } else {
//      /// 下载失败
//      resultData = ResultData('下载失败', false);
//    }

    Map<String, dynamic> data;
    if (response.data is Map) {
      data = response.data;
    } else {
      data = json.decode(response.data);
    }

    printBigLog("$_TAG data: ", json.encode(data));

    //处理错误部分
    if (statusCode == 200 || statusCode == 1) {

      Map<String, dynamic> map = Map.from(response.data);
      //成功
      return Future.value(map);

    }else if (statusCode == 201 || statusCode == 2 ) {
      //重新登录 跳转登录界面

      return Future.value(Map());
    }else {
      return Future.error(response.statusMessage);
    }




//    //处理错误部分
//    if (statusCode != 200) {
//      return Future.error(response.statusMessage);
//    }
//
//    //处理错误部分
//    if (statusCode != 200) {
//      errorMsg = "网络请求错误,状态码:" + statusCode.toString();
//      resultData = ResultData(errorMsg, false, url: url);
//      return Future.error(resultData.msg);
//    } else {
//      try {
//        resultData = ResultData.response(data);
//        return Future.value(resultData.data);
//      } catch (exception) {
//        resultData = ResultData(exception.toString(), true, url: url);
//        return Future.error(exception.toString());
//      }
//    }
  }

  static void printLog(String log, {tag}) {
    String tagLog;
    if (tag != null) {
      tagLog = tag + log;
    } else {
      tagLog = log;
    }
    debugPrint(tagLog);
  }

  static void printBigLog(String tag, String log) {
    //log = TEST_POEM;
    const MAX_COUNT = 800;
    if (log != null && log.length > MAX_COUNT) {
      // 超过1000就分次打印
      int len = log.length;
      int paragraphCount = ((len / MAX_COUNT) + 1).toInt();
      for (int i = 0; i < paragraphCount; i++) {
        int printCount = MAX_COUNT;
        if (i == paragraphCount -1) {
          printCount = len - (MAX_COUNT * (paragraphCount -1));
        }
        String finalTag = "" + tag + "\n";
        printLog(log.substring(i * MAX_COUNT, i * MAX_COUNT + printCount) + "\n", tag: finalTag);
      }
    } else {
      String tagLog;
      if (tag == null) {
        tagLog = tag + log;
      } else {
        tagLog = log;
      }
      printLog(tagLog);
    }
  }

  /*取消所有请求*/
  void cancelAll() {
    if (_cancelToken.isCancelled) {
      _cancelToken = CancelToken();
    } else {
      _cancelToken.cancel("cancelled");
    }
  }


}