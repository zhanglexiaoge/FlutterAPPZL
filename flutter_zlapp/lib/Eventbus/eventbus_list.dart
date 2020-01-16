import 'package:event_bus/event_bus.dart';

class EventBusUtil {
  static EventBus _eventBus;

  /*单例模式（懒汉模式）*/
  factory EventBusUtil() => _sharedInstance();
  static EventBusUtil _instance;

  EventBusUtil._();

  static EventBusUtil _sharedInstance() {
    if (_instance == null) {
      _instance = EventBusUtil._();
      _eventBus = EventBus();
    }
    return _instance;
  }

  EventBus getEventBus() {
    return _eventBus;
  }
}

class EventbusremoveFace {
  //face 表情id 移除某个表情
  String faceid = null;
  EventbusremoveFace(this.faceid);
}

class EventbusaddFace {
  //下载某个表情
  String faceid = null;
  EventbusaddFace(this.faceid);

}

class EventbusFaceReorder {
  //表情排序结果
  List<String > idList = new List();
  EventbusFaceReorder(this.idList);

}