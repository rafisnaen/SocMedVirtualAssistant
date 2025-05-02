import 'package:flutter/material.dart';
import 'package:virtual_assistant/voice_input_processor/vosk_handler.dart';

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
  VoskHandler recorder = VoskHandler();

  //Initial state
  @override
  void initState() {
    super.initState();
    recorder.initialize();
    isRecording = false;
    buttonText = "Record voice";
    buttonColor = Colors.lightBlueAccent;
  }

  //Changes appearance and behavior of the button
  void record(){
    setState(() {
      if(!isRecording){
        //Starts recording when clicked
        recorder.startRecord();
        buttonText = "Stop recording";
        buttonColor = Colors.redAccent;
      }
      else{
        //Stops recording when clicked again
        recorder.stopRecord();
        buttonText = "Record voice";
        buttonColor = Colors.lightBlueAccent;
      }
      isRecording = !isRecording;
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