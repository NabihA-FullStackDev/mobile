import 'package:flutter/material.dart';

class Header extends AppBar {
  Header({
    Key? key,
    required TextEditingController ctrl,
    required void Function(String) searched,
  }) : super(
          key: key,
          centerTitle: true,
          title: TextField(
            controller: ctrl,
            onChanged: (value) {
              value = ctrl.text;
            },
            onSubmitted: (value) {
              searched(value);
            },
            decoration: const InputDecoration(labelText: "Recherche"),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => {searched("Geolocation")},
                  icon: const Icon(Icons.location_pin),
                ),
              ],
            ),
          ],
        );
}
