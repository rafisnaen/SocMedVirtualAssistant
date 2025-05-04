import 'package:flutter/cupertino.dart';
import 'package:vosk_flutter/vosk_flutter.dart';
import 'dart:convert';
import 'package:virtual_assistant/app_menu_handler/UI_handler/text_transcript_displayer.dart';

class VoskHandler{
  //Variables about plugin set up
  late final VoskFlutterPlugin voskInstance;
  late final String modelPath;

  late bool isRecording; //Bool for button

  //Variables about model
  late final model;
  late final transcriber;

  //Variables about recording
  late var voiceRecorder;
  final ValueNotifier<String> textResult = ValueNotifier<String>("");

  static final VoskHandler handlerInstance = new VoskHandler();

  //To ensure displayer and button accesses the same object
  static VoskHandler getInstance(){
    return handlerInstance;
  }

  Future<void> instantiate() async{
    voskInstance = VoskFlutterPlugin.instance();
    modelPath = await ModelLoader().loadFromAssets('assets/models/vosk-model-small-en-us-0.15.zip');
  }

  Future<void> loadModel() async{
    model = await voskInstance.createModel(modelPath);

    //Create the speech-to-text service variable
    transcriber = await voskInstance.createRecognizer(
        model: model, sampleRate: 48000
    );

    isRecording = false;
  }

  Future<void> initialize() async{
    await instantiate();
    await loadModel();
  }

  Future<void> startRecord() async{
    voiceRecorder = await voskInstance.initSpeechService(transcriber);
    textResult.value = "";
    voiceRecorder.onResult().forEach((result)
      {
        //result is a JSON, needs to be decoded to get the string
        final tempRes = jsonDecode(result);
        final tempResString = tempRes['text'];
        if(tempResString != null && tempResString != ""){
          textResult.value += " $tempResString";
        }
      }
    );
    await voiceRecorder.start();
    isRecording = true;
  }

  Future<void> stopRecord() async{
    await voiceRecorder.stop();
    voiceRecorder.dispose();
    isRecording = false;

    //Give delay to wait for text result
    await Future.delayed(Duration(milliseconds: 250));
  }

  bool recording(){
    return isRecording;
  }

  void setRecordState(bool recording){
    isRecording = recording;
  }
}