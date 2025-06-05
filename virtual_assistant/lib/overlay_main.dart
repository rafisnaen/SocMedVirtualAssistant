import 'package:flutter/material.dart';

@pragma('vm:entry-point') // <<< WAJIB untuk overlay
void overlayMain() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: OverlayWidget(),
  ));
}

class OverlayWidget extends StatelessWidget {
  const OverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text(
          "Floating Overlay Active",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            backgroundColor: Colors.black87,
          ),
        ),
      ),
    );
  }
}
