
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_zlapp/Tool/objectisEmpty.dart';
import 'package:flutter_zlapp/Tool/nslog.dart';
class ImageUtils {

  static ImageProvider getAssetImage(String name, {String format: 'png'}) {
    return AssetImage(getImgPath(name, format: format));
  }

  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/appstart/$name.$format';
  }

  static ImageProvider getImageProvider(String imageUrl, {String holderImg: 'none'}) {
    if (ObjectUtil.isEmptyString(imageUrl)) {
      return AssetImage(getImgPath(holderImg));
    }
    return CachedNetworkImageProvider(imageUrl, errorListener: () => NSLog.e("图片加载失败！"));
  }
}