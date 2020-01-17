import 'package:flutter/material.dart';
import 'package:flutter_zlapp/Tool/application/application.dart';
import 'package:flutter_zlapp/Model/provider/userModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_zlapp/Router/routes.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:flutter_zlapp/Tool/Utils.dart';
import 'package:flutter_zlapp/Model/provider/theme_provider.dart';
import 'package:flutter_zlapp/Tool/constant.dart';
import 'package:flutter_zlapp/Tool/image_utils/image_utils.dart';
import 'package:flutter_zlapp/Tool/theme_utils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}
//广告页是204
class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {

  int _status = 0;
  List<String> _guideList = ['app_start_1', 'app_start_2', 'app_start_3'];
  StreamSubscription _subscription;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Utils.getInstance();
      // 由于SpUtil未初始化，所以MaterialApp获取的为默认主题配置，这里同步一下。
      Provider.of<ThemeProvider>(context, listen: false).syncTheme();
      if (Utils.getBool(Constant.keyGuide, defValue: true)) {
        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
        _guideList.forEach((image) {
          precacheImage(ImageUtils.getAssetImage(image), context);
        });
      }
      _initSplash();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _initSplash() {
//    Observable
//    rxdart
//    被观察对象
    _subscription = Observable.just(1).delay(Duration(milliseconds: 1500)).listen((_) {
      if (Utils.getBool(Constant.keyGuide, defValue: true)) {
        Utils.putBool(Constant.keyGuide, false);
        _initGuide();
      } else {
        goPage();
      }
    });
  }

  void goPage() async{
    UserModel userModel = Provider.of<UserModel>(context);
    userModel.initLoginModel();
    //判断是否登录
    if (userModel.loginModel != null) {
      //token存在 登录成功
      Application.router.navigateTo(context, Routes.tabbarpage,clearStack: true);
    } else {
      Application.router.navigateTo(context, Routes.login, clearStack: true);
    }
  }
 //FractionallyAlignedSizedBox 侧滑控件
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Application.screenWidth = size.width;
    Application.screenHeight = size.height;
    Application.statusBarHeight = MediaQuery.of(context).padding.top;
    Application.bottomBarHeight = MediaQuery.of(context).padding.bottom;
    return Material(
        color: ThemeUtils.getBackgroundColor(context),
        child: _status == 0 ? FractionallyAlignedSizedBox(
            heightFactor: 0.3,
            widthFactor: 0.33,
            leftFactor: 0.33,
            bottomFactor: 0,
            child:  Image.asset('assets/images/icon_logo.png')
        ) :
        Swiper(
          key: const Key('swiper'),
          itemCount: _guideList.length,
          loop: false,
          itemBuilder: (_, index) {
            return  Image.asset(
              ImageUtils.getImgPath(_guideList[index]),
              key:  Key(_guideList[index]),
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              /// 忽略图片语义
              excludeFromSemantics: true,
            );
          },
          onTap: (index) {
            if (index == _guideList.length - 1) {
              goPage();
            }
          },
        )
    );
  }
}