import 'package:diary_app/diary_app/utils/get_feeling.dart';
import 'package:diary_app/diary_app/widgets/entry_dial.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../api/db_delete_entry.dart';
import '../models/entry.dart';

class EntryTile extends StatelessWidget {
  final Entry item;
  final void Function() updateList;
  const EntryTile({super.key, required this.item, required this.updateList});

  void _openEntry(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return EntryDial(item: item);
        });
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final String date = DateFormat('EE d MMM yyyy - HH:mm', 'fr_FR')
        .format(item.getCreatedAt()!);
    Color itemsColor = Colors.white;
    Color backTileColor =
        const Color.fromARGB(255, 0, 103, 177).withOpacity(0.8);

    return FilledButton(
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.white.withOpacity(0))),
      onPressed: () => _openEntry(context),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        tileColor: backTileColor,
        leading: FaIcon(
          getFeeling(item.getFeeling()),
          size: 42,
          color: itemsColor,
        ),
        title: Text(
          item.getTitle(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: itemsColor),
        ),
        subtitle: Text(
          date,
          style: TextStyle(fontSize: 24, color: itemsColor),
        ),
        trailing: IconButton(
            onPressed: () async => {
                  await deleteEntry(user, item.getId()),
                  updateList(),
                },
            icon: FaIcon(
              FontAwesomeIcons.trashCan,
              size: 24,
              color: itemsColor,
            )),
      ),
    );
  }
}
