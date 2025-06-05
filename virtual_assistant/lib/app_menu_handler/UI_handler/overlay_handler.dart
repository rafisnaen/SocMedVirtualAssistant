import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class OverlayHandler {
  static Future<void> showFloatingButton() async {
    final isGranted = await FlutterOverlayWindow.isPermissionGranted();

    if (!isGranted) {
      await FlutterOverlayWindow.requestPermission();
    }

    final granted = await FlutterOverlayWindow.isPermissionGranted();
    if (granted) {
      await FlutterOverlayWindow.showOverlay(
        height: 200,
        width: 200,
        alignment: OverlayAlignment.centerRight,
        flag: OverlayFlag.defaultFlag,
        enableDrag: true,
      );
    } else {
      print("Overlay permission not granted.");
    }
  }

  static Future<void> closeFloatingButton() async {
    await FlutterOverlayWindow.closeOverlay();
  }
}
