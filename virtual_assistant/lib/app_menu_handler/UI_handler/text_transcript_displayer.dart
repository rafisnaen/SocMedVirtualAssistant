import 'package:flutter/material.dart';


class AudioInputDisplayer extends StatefulWidget {
  const AudioInputDisplayer({super.key});

  // Ganti ini: jangan pakai underscore agar bisa diakses dari luar file
  static final GlobalKey<_AudioInputDisplayerState> globalKey =
  GlobalKey<_AudioInputDisplayerState>();

  static void updateTranscript(String transcript, String response) {
    globalKey.currentState?.setTranscript(transcript, response);
  }

  @override
  State<AudioInputDisplayer> createState() => _AudioInputDisplayerState();
}

class _AudioInputDisplayerState extends State<AudioInputDisplayer> {
  String transcript = "";
  String response = "";

  void setTranscript(String newTranscript, String newResponse) {
    setState(() {
      transcript = newTranscript;
      response = newResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("🗣️ You said:"),
        Text(transcript, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        const Text("🤖 Gemini replied:"),
        Text(response, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
