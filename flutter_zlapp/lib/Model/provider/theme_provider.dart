import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zlapp/Tool/colors.dart';
import 'package:flutter_zlapp/Tool/styles.dart';
import 'package:flutter_zlapp/Tool/Utils.dart';
import 'package:flutter_zlapp/Tool/constant.dart';
//主题 provider 暗黑 夜间 正常模式 等等

class ThemeProvider extends ChangeNotifier {
  //Constant.theme //存入样式的key
  // Dark  Light  System
  static const Map<ThemeMode, String> themes = {
    ThemeMode.dark: 'Dark', ThemeMode.light : 'Light', ThemeMode.system : 'System'
  };

  void syncTheme() {
    String theme = Utils.getString(Constant.theme);
    if (theme.isNotEmpty && theme != themes[ThemeMode.system]) {
      notifyListeners();
    }
  }
  void setTheme(ThemeMode themeMode) {
    //把主题样式存入本地
    Utils.putString(Constant.theme, themes[themeMode]);
    notifyListeners();
  }
  ThemeMode getThemeMode(){
    //取出存入本地主题样式
    String theme = Utils.getString(Constant.theme);
    switch(theme) {
      case 'Dark':
        return ThemeMode.dark;
      case 'Light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }


  getTheme({bool isDarkMode: false}) {
    return ThemeData(
        errorColor: isDarkMode ? Colours.dark_red : Colours.red,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
        accentColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
        // Tab指示器颜色
        indicatorColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
        // 页面背景色
        scaffoldBackgroundColor: isDarkMode ? Colours.dark_bg_color : Colors.white,
        // 主要用于Material背景色
        canvasColor: isDarkMode ? Colours.dark_material_bg : Colors.white,
        // 文字选择色（输入框复制粘贴菜单）
        textSelectionColor: Colours.app_main.withAlpha(70),
        textSelectionHandleColor: Colours.app_main,
        textTheme: TextTheme(
          // TextField输入文字颜色
          subhead: isDarkMode ? TextStyles.textDark : TextStyles.text,
          // Text文字样式
          body1: isDarkMode ? TextStyles.textDark : TextStyles.text,
          subtitle: isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: isDarkMode ? Colours.dark_bg_color : Colors.white,
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        ),
        dividerTheme: DividerThemeData(
            color: isDarkMode ? Colours.dark_line : Colours.line,
            space: 0.6,
            thickness: 0.6
        ),
        cupertinoOverrideTheme: CupertinoThemeData(
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        )
    );
  }


}