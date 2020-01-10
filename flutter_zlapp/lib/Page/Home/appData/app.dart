///APP全局数据 多个界面共享数据

import 'package:event_bus/event_bus.dart';

class App {
  static final EventBus eventBus = new EventBus();
}