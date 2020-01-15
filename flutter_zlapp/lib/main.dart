import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_zlapp/Model/provider/userModel.dart';
import 'package:flutter_zlapp/Page/splashPage/splashPage.dart';
import 'package:flutter_zlapp/Router/routes.dart';
import 'package:flutter_zlapp/Tool/application/application.dart';
import 'package:flutter_zlapp/Model/provider/faceManageModel.dart';
void main() {
  // 强制竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  if (Platform.isAndroid) {
    /*控制状态栏底色*/
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  final router = Router();
  Routes.configureRoutes(router);
  Application.router = router;

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider<UserModel>(create:(_) => UserModel()),
          ChangeNotifierProvider<FaceManageModel>(create:(_) => FaceManageModel()),
        ],
        child: MyApp(),
    ));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return RefreshConfiguration (
     child:  MaterialApp(
       debugShowCheckedModeBanner: false,
       home: SplashPage(),
       onGenerateRoute: Application.router.generator,
     ),
      headerBuilder: () => ClassicHeader(
          height: 45.0,
          releaseText: '松开手刷新',
          refreshingText: '刷新中',
          completeText: '刷新完成',
          failedText: '刷新失败',
          idleText: '下拉刷新',
      ),
    footerBuilder: () => ClassicFooter(
      noDataText: "- 我是有底线的 -",
      loadingText: "- 加载中 -",
      failedText: "- 加载失败,请重试 -",
      canLoadingText: "- 松开加载 -",
      idleText: "- 上拉加载更多 -",
    ),
      hideFooterWhenNotFull: true
   );
  }

}


