import 'package:flutter/material.dart';

class ToggleSwitch extends StatefulWidget{
  const ToggleSwitch({super.key});

  @override
  State<ToggleSwitch> createState() => ToggleSwitchState();
}

class ToggleSwitchState extends State<ToggleSwitch>{
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isOn,
      onChanged: (bool value){
        setState(() {
            isOn = value;
          }
        );
      },
      activeColor: Colors.white,
      activeTrackColor: Colors.lightGreen,
    );
  }

  bool getCurrentState(){
    return isOn;
  }
}

