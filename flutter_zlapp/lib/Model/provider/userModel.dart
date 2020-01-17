import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_zlapp/Model/logIn/login_model_entity.dart';
import 'package:flutter_zlapp/Tool/HTTP/HttpUtil.dart';
import 'package:flutter_zlapp/Config/serviceUrl.dart';
import 'package:flutter_zlapp/Tool/Utils.dart';


class UserModel with ChangeNotifier {
  LoginModelEntity _loginModel;
  LoginModelEntity get loginModel => _loginModel;
  // 初始化 loginModel
  void initLoginModel() {
    if (Utils.haveKey('loginfo')) {
      //获取本地存储的登录信息
      String _loginfoTemp =  Utils.getString('loginfo');
      _loginModel = LoginModelEntity.fromJson(json.decode(_loginfoTemp));
    }
  }
    /// 登录
    Future<LoginModelEntity> login(BuildContext context, String phone, String pwd,String verify) async {
      Map<String, dynamic> params = {"username": phone,"password":pwd};
      var response = await HttpUtil.instance.post(loginOld,params: params);
      LoginModelEntity loginModel = LoginModelEntity.fromJson(response);
      _saveUserInfo(loginModel);
      return loginModel;
    }

    /// 保存用户信息到 sp
     _saveUserInfo(LoginModelEntity user){
      _loginModel = user;
      Utils.putString('loginfo', json.encode(user.toJson()));
    }

}