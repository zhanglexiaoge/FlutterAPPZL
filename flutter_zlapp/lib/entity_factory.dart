import 'package:flutter_zlapp/Page/Home/oneAppModel/one_page_list_model_entity.dart';
import 'package:flutter_zlapp/Page/Home/oneAppModel/onepageitem_model_entity.dart';
import 'package:flutter_zlapp/Model/Home/home_model_entity.dart';
import 'package:flutter_zlapp/Model/logIn/login_model_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "OnePageListModelEntity") {
      return OnePageListModelEntity.fromJson(json) as T;
    } else if (T.toString() == "OnepageitemModelEntity") {
      return OnePageItemEntity.fromJson(json) as T;
    } else if (T.toString() == "HomeModelEntity") {
      return HomeModelEntity.fromJson(json) as T;
    } else if (T.toString() == "LoginModelEntity") {
      return LoginModelEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}