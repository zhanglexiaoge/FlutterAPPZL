import 'package:flutter/material.dart';
import 'package:flutter_zlapp/Tool/application/application.dart';
import 'package:flutter_zlapp/Model/userModel/userModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_zlapp/Tabar/tabar.dart';
import 'package:flutter_zlapp/Page/Login/login.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}
//广告页是204
class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _logoController;
  Tween _scaleTween;
  CurvedAnimation _logoAnimation;

  @override
  void initState() {
    super.initState();
    _scaleTween = Tween(begin: 0, end: 1);
    _logoController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..drive(_scaleTween);
    Future.delayed(Duration(milliseconds: 500), () {
      _logoController.forward();
    });
    _logoAnimation =
        CurvedAnimation(parent: _logoController, curve: Curves.easeOutQuart);

    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 500), () {
          goPage();
        });
      }
    });
  }

  void goPage() async{
    await Application.initSp();
    UserModel userModel = Provider.of<UserModel>(context);
    userModel.initLoginModel();
    //判断是否登录
    if (userModel.loginModel != null) {
      //token存在 登录成功
      Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context) => TabarWidget()), (route) => route == null);
    } else
      Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context) => LoginView()), (route) => route == null);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Application.screenWidth = size.width;
    Application.screenHeight = size.height;
    Application.statusBarHeight = MediaQuery.of(context).padding.top;
    Application.bottomBarHeight = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ScaleTransition(
          scale: _logoAnimation,
          child: Hero(
            tag: 'logo',
            child: Image.asset('assets/images/icon_logo.png'),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _logoController.dispose();
  }
}