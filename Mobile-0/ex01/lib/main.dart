import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _displayText = "Here it is";

  void _onPressed() {
    setState(() {
      _displayText =
          (_displayText == "Hello World!") ? "Here it is" : "Hello World!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text(_displayText)),
            TextButton(
              onPressed: _onPressed,
              child: const Text("Push Me!"),
            ),
          ],
        ),
      ),
    );
  }
}
