import 'package:flutter/material.dart';
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
        if (value) {
          final hasPermission = await OverlayHandler.requestPermission();
          if (!hasPermission) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Overlay permission required")),
            );
            return;
          }
        }

        setState(() {
          isOn = value;
        });

        if (isOn) {
          await OverlayHandler.showFloatingButton();
        } else {
          await OverlayHandler.closeFloatingButton();
        }

      },
    );
  }
}