import 'package:flutter/material.dart';

import '../enums/nav_state.dart';

class CustomNavBar extends StatelessWidget {
  final void Function(NavState) navStateFunc;
  const CustomNavBar({super.key, required this.navStateFunc});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        backgroundColor:
            const Color.fromARGB(255, 0, 103, 177).withOpacity(0.8),
        destinations: [
          IconButton(
            onPressed: () => navStateFunc(NavState.profile),
            icon: const Icon(
              Icons.person,
              size: 42,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () => navStateFunc(NavState.calendar),
            icon: const Icon(
              Icons.calendar_month,
              size: 42,
              color: Colors.white,
            ),
          ),
        ]);
  }
}
