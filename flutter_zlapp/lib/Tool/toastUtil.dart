import 'package:oktoast/oktoast.dart';
import 'package:flutter/material.dart';

class ToastUtil {
  static void text(String text) {
    showToast(text,textPadding: EdgeInsets.only(left: 13,right: 13,top: 6,bottom: 6),radius: 5);
  }
}
