import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'overlay_handler.dart';

class ToggleSwitch extends StatefulWidget {
  const ToggleSwitch({super.key});

  @override
  State<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isOn,
      onChanged: (bool value) async {
        setState(() {
          isOn = value;
        });
        if (isOn) {
          await OverlayHandler.showFloatingButton();
        } else {
          await OverlayHandler.closeFloatingButton();
        }

        if (value) {
          final permission = await FlutterOverlayWindow.isPermissionGranted();
          if (permission == false) {
            await FlutterOverlayWindow.requestPermission();
          }

          await FlutterOverlayWindow.showOverlay(
            height: 200,
            width: 200,
            alignment: OverlayAlignment.centerRight,
            enableDrag: true,
          );
        } else {
          await FlutterOverlayWindow.closeOverlay();
        }
      },
    );
  }
}
