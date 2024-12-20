import 'package:flutter/material.dart';

import 'numpad.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalcState();
}

class _CalcState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Calculator")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(text: "0"),
                    textAlign: TextAlign.right,
                    textInputAction: TextInputAction.none,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(text: "0"),
                    textAlign: TextAlign.right,
                    textInputAction: TextInputAction.none,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Numpad(),
            ),
          ],
        ),
      ),
    );
  }
}
