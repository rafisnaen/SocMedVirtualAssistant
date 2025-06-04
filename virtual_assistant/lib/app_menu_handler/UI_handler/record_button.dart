import 'package:flutter/material.dart';
import 'package:virtual_assistant/voice_input_processor/vosk_handler.dart';
import '../../services/api_service.dart';
import '../../app_menu_handler/UI_handler/text_transcript_displayer.dart';

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
  VoskHandler recorder = VoskHandler.getInstance();

  //Initial state
  @override
  void initState() {
    super.initState();
    recorder.initialize();
    buttonText = "Record voice";
    buttonColor = Colors.lightBlueAccent;
  }

  //Changes appearance and behavior of the button
  void record() async {
    try {
      if (!recorder.recording()) {
        await recorder.startRecord();
        setState(() {
          buttonText = "Stop recording";
          buttonColor = Colors.redAccent;
        });
      } else {
        await recorder.stopRecord();
        setState(() {
          buttonText = "Record voice";
          buttonColor = Colors.lightBlueAccent;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❗ Gagal memproses rekaman: $e")),
      );
    }
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