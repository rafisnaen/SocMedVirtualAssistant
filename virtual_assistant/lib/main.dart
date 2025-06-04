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

  // This widget is the root of your application.
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
        //Top part of application
        backgroundColor: Colors.lightBlueAccent,
        title: const Text('Virtual Assistant'),
      ),

      body: Padding( //Gives padding so that content has space from screen edge
        padding: const EdgeInsets.all(20),
        child:
        Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, //Space between text and button
              children: [
                Text("Activate overlay"),
                ToggleSwitch() //Switch button
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Refresh overlay"), //No functionality yet, just placeholder
              ],
            ),
            const RecordButton(), //Recording button
            AudioInputDisplayer(key: AudioInputDisplayer.globalKey), //Transcript display area

            ValueListenableBuilder<String>(
              valueListenable: VoskHandler.getInstance().geminiReplyNotifier,
              builder: (context, reply, _) {
                return Text(
                  reply.isEmpty ? "Belum ada balasan dari Gemini" : "Gemini: $reply",
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
