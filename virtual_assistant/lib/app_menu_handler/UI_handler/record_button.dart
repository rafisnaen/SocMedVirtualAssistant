import 'package:flutter/material.dart';

class RecordButton extends StatefulWidget{
  const RecordButton({super.key});

  @override
  State<RecordButton> createState() => RecordButtonState();
}

class RecordButtonState extends State<RecordButton>{
  //Late variables (initialized later)
  late bool isRecording;
  late String buttonText;
  late MaterialAccentColor buttonColor;

  //Initial state
  @override
  void initState() {
    super.initState();
    isRecording = false;
    buttonText = "Record voice";
    buttonColor = Colors.lightBlueAccent;
  }

  //Changes appearance and behavior of the button
  void record(){
    setState(() {
      if(!isRecording){
        isRecording = true;
        buttonText = "Stop recording";
        buttonColor = Colors.redAccent;
      }
      else{
        isRecording = false;
        buttonText = "Record voice";
        buttonColor = Colors.lightBlueAccent;
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: record,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(buttonColor)
      ),
      child:
        Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white
          ),
        )
    );
  }
}