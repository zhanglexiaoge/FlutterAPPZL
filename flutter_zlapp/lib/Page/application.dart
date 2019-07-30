import 'package:flutter/material.dart';
import 'package:flutter_zlapp/APi/bannerApi.dart';
import 'package:flutter_zlapp/Model/bannerApiModel/banner_model.dart';
import 'package:flutter_zlapp/Model/bannerApiModel/staff_infro_model.dart';
import 'package:flutter_zlapp/Swiper/swiperView.dart';
class ApplicationPage extends StatefulWidget {
  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  String homePageContent='正在获取数据';
   //获取轮播图数据
   Future <List<BannerModel>>_getBannerData ()async {
      /*轮播图Banner*/
      List<BannerModel> bannerWaitList;
      bannerWaitList = await BannerApi.getInstance().getBannerModelData(context, true);
      staffInfroModel infroModel =  await BannerApi.getInstance().postSelfInfro(context, true);
      return bannerWaitList;
   }
   //获取个人信息数据
   Future <staffInfroModel> _postStaffInfroModel ()async {
     staffInfroModel infroModel =  await BannerApi.getInstance().postSelfInfro(context, true);
     return infroModel;
   }
  @override
  Widget build(BuildContext context) {
    return new  MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('发现'),
        ),
        body:  FutureBuilder <List<BannerModel>>(
          future: _getBannerData(),
          builder: (BuildContext context, AsyncSnapshot<List<BannerModel>> snapshot){
            return new Column(children: <Widget>[
                      SwiperView(swiperDataList: snapshot.data,)
                    ]);
          } ,

        )
     ),
    );
  }

}

