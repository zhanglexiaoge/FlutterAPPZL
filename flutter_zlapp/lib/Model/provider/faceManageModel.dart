import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_zlapp/Model/DeatilPage/detail_model_entity.dart';

//class FaceManageModel extends DetailModelDataList   extends 继承于
class FaceManageModel   with ChangeNotifier {
  //已下载的表情
  List  <DetailModelDataList>_listfacedata = [];
  //get 方法
  List <DetailModelDataList> get listface => _listfacedata;
  //set 方法
  set listface( List<DetailModelDataList> value) {
    _listfacedata = value;
    notifyListeners();
  }
  /*刷新*/
  void update() {
    notifyListeners();
  }

}