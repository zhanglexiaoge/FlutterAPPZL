import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_zlapp/Model/bannerApiModel/banner_model.dart';

class SwiperView extends StatelessWidget {
  //声明一个List,存放 image widget
 List <BannerModel> swiperDataList;
  //调用参数 构造函数
  SwiperView({this.swiperDataList});
  @override
  Widget build(BuildContext context) {
    if (swiperDataList == null) {
      swiperDataList = List <BannerModel>();
    }
    return Container(
       height: 280.0,
       child: Swiper(
         itemBuilder: (BuildContext context, int index){
           return Image.network("${swiperDataList[index].bigImg}",fit:BoxFit.fill);
         },
         itemCount: swiperDataList.length,
         pagination: new SwiperPagination(alignment: Alignment.bottomCenter),
         autoplay: true,
       ),
    );
  }
}