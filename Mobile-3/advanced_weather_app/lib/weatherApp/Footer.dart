import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const Footer({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primary = const Color.fromARGB(255, 0, 137, 205);
    Color backColor = const Color.fromARGB(255, 225, 129, 161).withOpacity(0.2);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedFontSize: 16,
      unselectedFontSize: 12,
      fixedColor: primary,
      backgroundColor: backColor,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          label: "Currently",
          icon: Icon(
            Icons.access_time,
            color: primary,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.today,
            color: primary,
          ),
          label: "Today",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.date_range,
            color: primary,
          ),
          label: "Weekly",
        ),
      ],
    );
  }
}
