import 'package:flutter/services.dart';

class OverlayHandler {
  static const MethodChannel _channel =
  MethodChannel('com.example.virtual_assistant/overlay');

  static Future<bool> requestPermission() async {
    try {
      return await _channel.invokeMethod('requestPermission');
    } on PlatformException catch (e) {
      print("Failed to request permission: ${e.message}");
      return false;
    }
  }

  static Future<void> showFloatingButton() async {
    try {
      await _channel.invokeMethod('startOverlay');
    } on PlatformException catch (e) {
      print("Failed to show overlay: ${e.message}");
    }
  }

  static Future<void> closeFloatingButton() async {
    try {
      await _channel.invokeMethod('stopOverlay');
    } on PlatformException catch (e) {
      print("Failed to close overlay: ${e.message}");
    }
  }
}