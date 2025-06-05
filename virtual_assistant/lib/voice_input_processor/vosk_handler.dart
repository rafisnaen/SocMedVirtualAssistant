import 'package:flutter/cupertino.dart';
import 'package:vosk_flutter/vosk_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:virtual_assistant/app_menu_handler/UI_handler/overlay_handler.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';


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
  final ValueNotifier<String> geminiReplyNotifier = ValueNotifier<String>("");
  final FlutterTts flutterTts = FlutterTts();



  //To ensure displayer and button accesses the same object
  static VoskHandler getInstance(){
    return handlerInstance;
  }

  Future<bool> checkMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
    }
    return status.isGranted;
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

    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
  }

  Future<void> startRecord() async{
    bool hasPermission = await checkMicrophonePermission();
    if (!hasPermission) {
      // Tampilkan pesan atau handle kalau permission ditolak
      print("Microphone permission denied");
      return;
    }
    voiceRecorder = await voskInstance.initSpeechService(transcriber);
    textResult.value = "";
    voiceRecorder.onResult().listen((result)
      {
        //result is a JSON, needs to be decoded to get the string
        final url = Uri.parse("http://192.168.0.102:5000/ask_gemini");
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

  Future<void> stopRecord() async {
    await voiceRecorder.stop();
    voiceRecorder.dispose();
    isRecording = false;

    await Future.delayed(Duration(milliseconds: 250));

    final inputText = textResult.value.trim();
    if (inputText.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse("http://192.168.0.102:5000/api/chat"),  // sesuaikan endpoint
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'prompt': inputText}),          // sesuaikan key jadi 'prompt'
        );

        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);
          final reply = result['response'];
          print("Gemini response: $reply");

          geminiReplyNotifier.value = reply;
          await flutterTts.speak(reply);
          if (await FlutterOverlayWindow.isPermissionGranted()) {
            FlutterOverlayWindow.showOverlay(); // tampilkan overlay
          } else {
            print("❗ Overlay permission not granted, skipping overlay.");
          }

        } else {
          print("Error dari server Gemini: ${response.statusCode}");
        }
      } catch (e) {
        print("❗ Gagal mengirim request ke Gemini: $e");
      }
    } else {
      print("Input text kosong, tidak mengirim request.");
    }
  }
  bool recording(){
    return isRecording;
  }
  void setRecordState(bool recording){
    isRecording = recording;
  }

}