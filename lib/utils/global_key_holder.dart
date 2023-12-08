import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

class GlobalKeyHolder {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  static final event = EventBus();
}
