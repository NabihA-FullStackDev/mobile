import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../models/entry.dart';
import '../utils/get_feeling.dart';

class EntryDial extends StatelessWidget {
  final Entry item;
  const EntryDial({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Color backColor = const Color.fromARGB(255, 0, 103, 177).withOpacity(0.9);
    Color itemColor = Colors.white;
    final String date =
        DateFormat('EE d MMM yyyy', 'fr_FR').format(item.getCreatedAt()!);

    return AlertDialog(
      backgroundColor: backColor,
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FaIcon(
            getFeeling(item.getFeeling()),
            size: 42,
            color: itemColor,
          ),
          SizedBox(width: 15),
          Text(
            date,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: itemColor,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: FaIcon(
              FontAwesomeIcons.xmark,
              color: itemColor,
            ),
          ),
        ],
      ),
      title: Text(
        item.getTitle(),
        style: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.bold,
          color: itemColor,
        ),
      ),
      content: SingleChildScrollView(
        child: Text(
          item.getText(),
          style: TextStyle(
            fontSize: 28,
            color: itemColor,
          ),
        ),
      ),
    );
  }
}
