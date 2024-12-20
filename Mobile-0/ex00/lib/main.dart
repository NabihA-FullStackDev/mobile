import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(child: Text("Here it is")),
            TextButton(onPressed: onPressed, child: const Text("Push Me!")),
          ],
        ),
      ),
    );
  }

  void onPressed() {
    print("Button \"Push Me\" pressed!");
  }
}
