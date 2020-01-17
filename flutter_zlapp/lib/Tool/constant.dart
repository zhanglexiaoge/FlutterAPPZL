import 'package:flutter/material.dart';

class Constant {
  /// debug开关，上线需要关闭
  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  /// 判断是否生产环境
  static const bool inProduction  = const bool.fromEnvironment('dart.vm.product');

  static const String keyGuide = 'keyGuide';

  static const String theme = 'AppTheme';

}