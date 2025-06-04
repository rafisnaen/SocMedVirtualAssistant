import 'package:flutter/material.dart';
import '../../voice_input_processor/vosk_handler.dart';

class AudioInputDisplayer extends StatefulWidget {
  static final GlobalKey<_AudioInputDisplayerState> globalKey = GlobalKey();

  const AudioInputDisplayer({super.key});

  @override
  State<AudioInputDisplayer> createState() => _AudioInputDisplayerState();
}

class _AudioInputDisplayerState extends State<AudioInputDisplayer> {
  final handler = VoskHandler.getInstance();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text("😸You said:", style: TextStyle(fontWeight: FontWeight.bold)),
        ValueListenableBuilder<String>(
          valueListenable: handler.textResult,
          builder: (context, value, child) {
            return Text(value.isEmpty ? "(kosong)" : value);
          },
        ),
        const SizedBox(height: 20),
        const Text("🎧Gemini replied:", style: TextStyle(fontWeight: FontWeight.bold)),
        ValueListenableBuilder<String>(
          valueListenable: handler.geminiReplyNotifier,
          builder: (context, value, child) {
            return Text(value.isEmpty ? "(belum ada jawaban)" : value);
          },
        ),
      ],
    );
  }
}
