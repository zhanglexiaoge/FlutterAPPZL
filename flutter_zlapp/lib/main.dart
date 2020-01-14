import 'package:flutter/material.dart';
import 'Tabar/tabar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_zlapp/Model/userModel/userModel.dart';
import 'package:flutter_zlapp/Page/splashPage/splashPage.dart';
void main() {
  if (Platform.isAndroid) {
    /*控制状态栏底色*/
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider<UserModel>(
            builder: (_) => UserModel(),
          ),
        ],
        child: MyApp(),
    ));


}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    _validateLogin().then((v){
//       if(v == false) {
//         Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context) => LoginView()), (route) => route == null);
//       }
//    });
  return RefreshConfiguration (
     child:  MaterialApp(
      home: SplashPage(),
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

//  Future <bool>_validateLogin() async{
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('token');
//    print('token ===' + token);
//    if(token == null) {
//      return true;
//    }else {
//      return false;
//    }
//  }

}


