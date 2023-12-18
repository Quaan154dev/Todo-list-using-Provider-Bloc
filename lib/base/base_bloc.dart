import 'dart:async';
import 'package:flutter/material.dart';
import 'base_event.dart';

abstract class BaseBloc {
  final StreamController<BaseEvent> _eventStreamController =
      StreamController<BaseEvent>();

  Sink<BaseEvent> get getevent => _eventStreamController.sink;

  BaseBloc() {
    // lắng nghe event của các base_bloc có thể cái sử dụng dc
    _eventStreamController.stream.listen((event) {
      if (event is! BaseEvent) {
        throw Exception("Event is not a BaseEvent");
      }
      dispatchEvent(event);
    });
  }

  void dispatchEvent(BaseEvent event); // xử lí hành động

  @mustCallSuper
  void dispose() {
    _eventStreamController.close();
  }
}
