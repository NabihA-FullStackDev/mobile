import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const Footer({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          label: "Currently",
          icon: Icon(Icons.access_time),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.today),
          label: "Today",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.date_range),
          label: "Weekly",
        ),
      ],
    );
  }
}
