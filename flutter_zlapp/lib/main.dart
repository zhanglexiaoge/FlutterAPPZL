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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_zlapp/Model/provider/theme_provider.dart';
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

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return RefreshConfiguration (
     child: OKToast(
        // OKToast为一般情况下,一个 flutter 应用应该只有一个 MaterialApp(或是 WidgetsApp/CupertinoApp), 这里包裹后,可以缓存 Context 到 内存中,后续在调用显示时,不用传入 BuildContext
       child: MultiProvider(
         providers: [
           ChangeNotifierProvider<UserModel>(create:(_) => UserModel()),
           ChangeNotifierProvider<FaceManageModel>(create:(_) => FaceManageModel()),
           ChangeNotifierProvider<ThemeProvider>(create:(_) => ThemeProvider()),
         ],
          child:  Consumer(
            builder: (context,ThemeProvider provider,_) => MaterialApp(
                theme: provider.getTheme(),
                darkTheme: provider.getTheme(isDarkMode: true),
                themeMode: provider.getThemeMode(),
                debugShowCheckedModeBanner: false,
                home: SplashPage(),
                onGenerateRoute: Application.router.generator,
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  const Locale('zh', 'CH'),
                  const Locale('en', 'US')
                ]
            ),
          ),
       ),
     ),
      headerBuilder: () => ClassicHeader(
        height: 45.0,
        releaseText: '松开手刷新',
        refreshingText: '刷新中',
        completeText: '刷新完成',
        failedText: '刷新失败',
        idleText: '下拉刷新',),
    footerBuilder: () => ClassicFooter(
        noDataText: "- 我是有底线的 -",
        loadingText: "- 加载中 -",
        failedText: "- 加载失败,请重试 -",
        canLoadingText: "- 松开加载 -",
        idleText: "- 上拉加载更多 -",),
    hideFooterWhenNotFull: true,
   );
  }

}


