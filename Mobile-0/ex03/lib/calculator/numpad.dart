import 'package:flutter/material.dart';

class Numpad extends StatelessWidget {
  final Function(String) onButtonPressed;

  Numpad({required this.onButtonPressed});

  final List<List<String>> buttons = [
    ["7", "8", "9", "C", "AC"],
    ["4", "5", "6", "+", "-"],
    ["1", "2", "3", "x", "÷"],
    ["", "0", "", ".", "="],
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final buttonWidth = screenWidth / 5;
    final buttonHeight = screenHeight / 10;

    return Table(
      children: buttons.map((row) {
        return TableRow(
          children: row.map((button) {
            return SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton(
                onPressed: () {
                  if (button.isNotEmpty) {
                    onButtonPressed(button);
                  }
                },
                child: Text(
                  button,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
