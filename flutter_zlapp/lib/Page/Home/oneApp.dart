import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_zlapp/Page/Home/oneAPPPage/onePage.dart';
import 'package:flutter_zlapp/Page/Home/oneAPPPage/allPage.dart';
import 'package:flutter_zlapp/Page/Home/oneAPPPage/mePage.dart';
import 'package:flutter_zlapp/Page/Home/toolTabar_list_event/toolTabar_list_event.dart';
import 'package:flutter_zlapp/Page/Home/appData/app.dart';



void main() {
  runApp(OneAppPage());
  if (Platform.isAndroid) {
    ///设置Android状态栏透明
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class OneAppPage extends StatefulWidget {
  @override
  _OneAppPageState createState() => _OneAppPageState();
}

class _OneAppPageState extends State<OneAppPage> {
  final _tabTitles = <String>['ONE', 'ALL', 'ME'];
  final _tabTextStyleNormal = TextStyle(color: Colors.black45);
  final _tabTextStyleSelected = TextStyle(color: Colors.black);

  int _tabIndex = 0;
  var _tabImages;
  var _tabPages;
  var _body;

  ///ONE页面点击TooBar展开列表隐藏底部Bar
  bool isShowList = false;

  @override
  void initState() {
    super.initState();
    _tabImages ??= <List<Image>>[
      [
        getTabImage('assets/images/oneAPP/ic_one_normal.png'),
        getTabImage('assets/images/oneAPP/ic_one_selected.png')
      ],
      [
        getTabImage('assets/images/oneAPP/ic_all_normal.png'),
        getTabImage('assets/images/oneAPP/ic_all_selected.png')
      ],
      [
        getTabImage('assets/images/oneAPP/ic_me_normal.png'),
        getTabImage('assets/images/oneAPP/ic_me_selected.png')
      ],
    ];
    _tabPages ??= <Widget>[OnePage(), AllPage(), MePage()];
    App.eventBus.on<toolTabar_list_event>().listen((event) {
      setState(() {
        //监听变化并更新状态
        isShowList = event.isShowList;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Image getTabImage(imagePath) {
    return Image.asset(imagePath, width: 22, height: 22);
  }

  Image getTabIcon(int index) {
    if (_tabIndex == index) {
      return _tabImages[index][1];
    }
    return _tabImages[index][0];
  }

  TextStyle getTabTextStyle(int index) {
    if (_tabIndex == index) {
      return _tabTextStyleSelected;
    }
    return _tabTextStyleNormal;
  }

  Text getTabTitle(index) {
    return Text(
      _tabTitles[index],
      style: getTabTextStyle(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    _body = IndexedStack(
      children: _tabPages,
      index: _tabIndex,
    );

    //    Thmedata primarySwatch是主题颜色的一个样本。通过这个样本可以在一些条件下生成一些其他的属性。
    //    例如，若没有指定primaryColor，并且当前主题不是深色主题，那么primaryColor就会默认为primarySwatch指定的颜色，
    //    还有一些相似的属性：accentColor、indicatorColor等也会受到primarySwatch的影响。
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFFFFFFF),
      ),
      home: Scaffold(
        body: _body,
        bottomNavigationBar: isShowList
            ? null
            : CupertinoTabBar(
          backgroundColor: Color(0xFFFFFFFF),
          items: [
            BottomNavigationBarItem(
                icon: getTabIcon(0), title: getTabTitle(0)),
            BottomNavigationBarItem(
                icon: getTabIcon(1), title: getTabTitle(1)),
            BottomNavigationBarItem(
                icon: getTabIcon(2), title: getTabTitle(2)),
          ],
          currentIndex: _tabIndex,
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ),
      ),

    );
  }
}
