export 'package:flutter_zlapp/Config/request.dart';
import 'dart:io';
import 'package:flutter_zlapp/Config/request.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_zlapp/Tool/dialog_param.dart';
import 'package:flutter_zlapp/Tool/loading_dialog.dart';
import 'package:flutter_zlapp/Config/serviceUrl.dart';
import 'package:flutter_zlapp/Config/result_data.dart';


class HttpReq extends  NetService {
  HttpReq();
  @override
  request(String url, {Method method, Map<String, dynamic> params, var file, String fileName,String fileSavePath, BuildContext context, bool showLoad = false}) async {
    /// 传参进行统一处理, 加上基本参数
    Map<String, dynamic> basicParam = await getBasicParam();
    basicParam["timeStamp"] = (new DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    if (params != null) {
      basicParam.addAll(params);
    }
    ShowParam showParam = new ShowParam(show: showLoad, barrierDismissible: false, showBackground: false);
    LoadingDialogUtil.showLoadingDialog(context, showParam);
    ResultData resultData = await super.request(url,method: method, params: basicParam, file: file, fileName: fileName,fileSavePath: fileSavePath);
    showParam.pop();

    /// 当apiToken 过期或者错误时的提示码
    if (resultData.code == 0 && context != null) {
      // 退出登录并跳转到登录界面
      //App.navigateTo(context, QuRoutes.ROUTE_MINE_LOGIN, clearStack: true);
    }

    return resultData;
  }

  @override
  getBasicUrl() {
    return BaseserviceUrl;
  }

  @override
  getHeaders() async{
    Map<String, dynamic> headers;
    headers = { "HC-ACCESS-TOKEN" : "czo2MDoiOTIxMzF0OW5ETGM4bjJ0WXZ6K2N0OUdHQU1qaTNPN3pGeVYrM3M0eEc4bUJsdEVma0VYa2lBMXBsUGtUIjs="};
    return headers;
  }

  Future<Map<String, dynamic>> getBasicParam() async {
    //dart:io 设备信息
    Map<String, dynamic> basicParam = {};
    basicParam["agent"] = Platform.isAndroid ? "android" : "ios";
    return basicParam;
  }
}