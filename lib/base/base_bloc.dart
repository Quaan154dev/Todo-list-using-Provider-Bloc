import 'dart:async';
import 'package:flutter/material.dart';
import 'base_event.dart';

// base : khởi tạo cơ sở chi event hay bloc
abstract class BaseBloc {
  final StreamController<BaseEvent> _eventStreamController =
      StreamController<BaseEvent>();

  Sink<BaseEvent> get getevent => _eventStreamController.sink;
  //widget bắn event vào tới Bloc thông qua sink

  BaseBloc() {
    // check xem đã mới truyền vào
    // lắng nghe event của các base_bloc có thể cái sử dụng dc
    _eventStreamController.stream.listen((event) {
      if (event is! BaseEvent) {
        throw Exception("Event is not a BaseEvent");
      }
      dispatchEvent(event);
    });
  }

  void dispatchEvent(BaseEvent event); // xử lí hành động  (interface)

  @mustCallSuper
  void dispose() {
    // khi tạo  ra 1 thằng StreamController thì phải đóng lại
    _eventStreamController.close();
  }
}
