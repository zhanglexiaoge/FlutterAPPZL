
import 'package:flutter/widgets.dart';
import 'package:flutter_zlapp/Config/Httpreq/httpreq.dart';
import 'package:flutter_zlapp/Config/result_data.dart';
import 'package:flutter_zlapp/Model/bannerApiModel/banner_model.dart';
import 'package:flutter_zlapp/Config/serviceUrl.dart';
import 'package:flutter_zlapp/Model/bannerApiModel/staff_infro_model.dart';

class BannerApi extends HttpReq  {
  /// 获取banner的接口
  static const getbannerUrlPath = bannerUrlPath; // bannner信息

  /// 获取个人信息的接口
  static const selfInfroPathUrlPath = postSelfInfroPath; 
  //获取公司文档
  static const postSysfilePath = postsysfilePath;
  BannerApi._();

  static BannerApi _instance;
  static BannerApi getInstance() {
    if (_instance == null) {
      _instance = BannerApi._();
    }
    return _instance;
  }
  //获取bannner 数据
  Future  <List<BannerModel>> getBannerModelData(BuildContext context, bool showProgress) async{
     Map<String, dynamic> param = {}; 
     ResultData resultData = await get(getbannerUrlPath, params: param, context: context, showLoad: showProgress);
      /*轮播图Banner*/
     List<BannerModel> bannerWaitList = List<BannerModel> ();
     if (resultData.isSuccess()) {
        bannerWaitList = getBannerModelList(resultData.data);
     }
     return bannerWaitList;
  }

 //获取个人信息 数据 staffInfroModel
  Future <staffInfroModel> postSelfInfro (BuildContext context, bool showProgress ) async{
  Map<String, dynamic> param = {'device':'iPhone Simulator','version':'ios.3.1.7.28'}; 
  ResultData resultData = await post(selfInfroPathUrlPath,params: param,context:context,showLoad: showProgress);
  staffInfroModel model ;
  if (resultData.isSuccess()) {
    model = staffInfroModel.fromJson(resultData.data);
  }
  return model;
  }
  
  //获取公司文档
  Future getsysfile (BuildContext context, bool showProgress,int page) async{
     Map<String, dynamic> param = {'page':page}; 
     ResultData resultData = await get(postSysfilePath,params: param,context:context,showLoad: showProgress);
     if (resultData.isSuccess()) {
       print(resultData.data);
     }
  }
}
