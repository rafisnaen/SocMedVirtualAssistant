import 'package:flutter/cupertino.dart';
import 'package:virtual_assistant/voice_input_processor/vosk_handler.dart';

class AudioInputDisplayer extends StatelessWidget{
  AudioInputDisplayer({super.key});
  static final VoskHandler handler = VoskHandler.getInstance();

  @override
  Widget build(BuildContext context){
    return ValueListenableBuilder(
        valueListenable: handler.textResult, //Checks on changes on textResult
        builder: (context, text, child){
          return Text(text); //Gives text with value of the textResult
        }
    );
  }
}