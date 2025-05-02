import 'package:vosk_flutter/vosk_flutter.dart';

class VoskHandler{
  late final VoskFlutterPlugin voskInstance;
  late final String modelPath;

  late final model;
  late final transcriber;

  late final voiceRecorder;

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
  }

  Future<void> initialize() async{
    await instantiate();
    await loadModel();
  }

  Future<void> startRecord() async{
    voiceRecorder = await voskInstance.initSpeechService(transcriber);
    voiceRecorder.onResult().forEach((result) => print(result));
    await voiceRecorder.start();
  }

  Future<void> stopRecord() async{
    await voiceRecorder.stop();
    voiceRecorder.dispose();
  }
}