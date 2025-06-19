import 'package:flutter/material.dart';
import 'app_menu_handler/UI_handler/toggle_switch.dart';
import 'app_menu_handler/UI_handler/record_button.dart';
import 'app_menu_handler/UI_handler/text_transcript_displayer.dart';
import 'package:virtual_assistant/voice_input_processor/vosk_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Virtual Assistant',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text('Virtual Assistant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Activate overlay"),
                ToggleSwitch()
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Refresh overlay"),
              ],
            ),
            const RecordButton(),
            AudioInputDisplayer(key: AudioInputDisplayer.globalKey),
          ],
        ),
      ),
    );
  }
}
