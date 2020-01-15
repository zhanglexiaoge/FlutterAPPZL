import 'package:flutter_zlapp/Page/Home/oneAppModel/one_page_list_model_entity.dart';
import 'package:flutter_zlapp/Page/Home/oneAppModel/onepageitem_model_entity.dart';
import 'package:flutter_zlapp/Page/Home/oneAppModel/one_page_tool_bar_list_item_entity.dart';
import 'package:flutter_zlapp/Model/Home/home_model_entity.dart';
import 'package:flutter_zlapp/Model/logIn/login_model_entity.dart';
import 'package:flutter_zlapp/Model/DeatilPage/detail_model_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "OnePageListModelEntity") {
      return OnePageListModelEntity.fromJson(json) as T;
    } else if (T.toString() == "OnePageItemEntity") {
      return OnePageItemEntity.fromJson(json) as T;
    } else if (T.toString() == "OnePageToolBarListItemEntity") {
      return OnePageToolBarListItemEntity.fromJson(json) as T;
    } else if (T.toString() == "HomeModelEntity") {
      return HomeModelEntity.fromJson(json) as T;
    } else if (T.toString() == "LoginModelEntity") {
      return LoginModelEntity.fromJson(json) as T;
    } else if (T.toString() == "DetailModelEntity") {
      return DetailModelEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}