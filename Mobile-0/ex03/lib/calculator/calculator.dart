import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'numpad.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalcState();
}

class _CalcState extends State<Calculator> {
  String input = "";
  String result = "0";

  void onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        input = input.isNotEmpty ? input.substring(0, input.length - 1) : "";
      } else if (value == "AC") {
        input = "";
        result = "0";
      } else if (value == "=") {
        try {
          Parser parser = Parser();
          Expression exp =
              parser.parse(input.replaceAll("x", "*").replaceAll("÷", "/"));
          ContextModel context = ContextModel();
          result = exp.evaluate(EvaluationType.REAL, context).toString();
        } catch (e) {
          result = "Erreur";
        }
      } else {
        input += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Calculator")),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(text: input),
                    textAlign: TextAlign.right,
                    textInputAction: TextInputAction.none,
                    decoration: const InputDecoration(border: InputBorder.none),
                    style: const TextStyle(fontSize: 24),
                  ),
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(text: result),
                    textAlign: TextAlign.right,
                    textInputAction: TextInputAction.none,
                    decoration: const InputDecoration(border: InputBorder.none),
                    style: const TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Numpad(onButtonPressed: onButtonPressed),
            ),
          ],
        ),
      ),
    );
  }
}
