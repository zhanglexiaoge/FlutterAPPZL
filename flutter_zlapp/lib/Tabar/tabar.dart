import 'package:flutter/material.dart';
import 'package:flutter_zlapp/Page/home.dart';
import 'package:flutter_zlapp/Page/application.dart';
import 'package:flutter_zlapp/Page/mine.dart';


//快捷 生成代码 stful

class TabarWidget extends StatefulWidget {
  @override
  
  _TabarWidgetState createState() => _TabarWidgetState();
}
//是继承于State，其实State部分才是我们的重点，主要的代码都会写在State中。
class _TabarWidgetState extends State<TabarWidget> {
  int _selectedIndex = 0;
  var tabImages;
  var appBarTitles = ['首页', '发现', '我的'];
  /*
   * 存放三个页面，跟fragmentList一样
   */
  var _pageList;

  /*
   * 根据选择获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _selectedIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == _selectedIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xff1296db)));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xff515151)));
    }
  }
  
  /*
   * 根据image路径获取图片
   */
  Image getTabImage(path) {
    return new Image.asset(path, width: 24.0, height: 24.0);
  }
  
  void initData() {
    /*
     * 初始化选中和未选中的icon
     */
    tabImages = [
      [getTabImage('assets/images/message.png'), getTabImage('assets/images/message_selected.png')],
      [getTabImage('assets/images/application.png'), getTabImage('assets/images/application_selected.png')],
      [getTabImage('assets/images/me.png'), getTabImage('assets/images/me_selected.png')]
    ];
    /*
     * 三个子界面
     */
    _pageList = [
      new HomePage(),
      new ApplicationPage(),
      new MinePage(),
    ];
}
  @override
  
  Widget build(BuildContext context) {
    //初始化数据
    initData();
    return Scaffold( //脚手架
       body: _pageList[_selectedIndex],
       bottomNavigationBar: new BottomNavigationBar(
         items: <BottomNavigationBarItem> [
           new BottomNavigationBarItem(
             icon: getTabIcon(0), title: getTabTitle(0)
           ),
           new BottomNavigationBarItem(
             icon: getTabIcon(1), title: getTabTitle(1)
           ),
           new BottomNavigationBarItem(
             icon: getTabIcon(2), title: getTabTitle(2)
           ),
         ],
         type: BottomNavigationBarType.fixed,
         //默认选中首页
         currentIndex: _selectedIndex,
         iconSize: 24.0,
         //点击事件
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
       ),
    );
  }
}