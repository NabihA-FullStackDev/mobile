import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../api/db_create_entry.dart';

class EntryForm extends StatefulWidget {
  final void Function() updateEntries;
  const EntryForm({
    super.key,
    required this.updateEntries,
  });

  @override
  State<EntryForm> createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  User? user = FirebaseAuth.instance.currentUser;
  Color backColor = const Color.fromARGB(255, 36, 13, 187).withOpacity(0.9);
  Color itemColor = Colors.white;
  Color titleColor = Colors.white;
  Color textColor = Colors.white;
  String feeling = "hoppy";
  String titleValue = "";
  String textValue = "";

  void updateFeeling(String feel) {
    setState(() {
      feeling = feel;
    });
  }

  void updateTitle(String title) {
    setState(() {
      titleValue = title;
    });
  }

  void updateText(String text) {
    setState(() {
      textValue = text;
    });
  }

  void errorField() {
    if (titleValue == "") {
      setState(() {
        titleColor = Colors.pink;
      });
    } else {
      setState(() {
        titleColor = itemColor;
      });
    }
    if (textValue == "") {
      setState(() {
        textColor = Colors.pink;
      });
    } else {
      setState(() {
        textColor = itemColor;
      });
    }
  }

  void saveEntry() async {
    if (user != null && titleValue.isNotEmpty && textValue.isNotEmpty) {
      await createEntry(
        user,
        titleValue,
        textValue,
        feeling,
      );
      widget.updateEntries();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backColor,
      title: Text(
        "Nouvelle entrée de Journal",
        style: TextStyle(color: itemColor, fontSize: 32),
      ),
      insetPadding: EdgeInsets.symmetric(vertical: 150),
      content: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _dropDownButton(),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Titre",
                  labelStyle: TextStyle(
                    color: titleColor,
                    fontSize: 25,
                  ),
                ),
                initialValue: "",
                style: TextStyle(
                  color: itemColor,
                  fontSize: 25,
                ),
                onChanged: (value) => updateTitle(value),
              ),
              SingleChildScrollView(
                child: TextFormField(
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: "Entrée",
                    labelStyle: TextStyle(
                      color: textColor,
                      fontSize: 25,
                    ),
                  ),
                  initialValue: "",
                  style: TextStyle(color: itemColor, fontSize: 25),
                  onChanged: (value) => updateText(value),
                ),
              ),
              TextButton(
                onPressed: () => (titleValue.isNotEmpty && textValue.isNotEmpty)
                    ? saveEntry()
                    : errorField(),
                child: Text(
                  "Enregistrer l'entrée",
                  style: TextStyle(color: itemColor, fontSize: 28),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _dropDownButton() {
    return DropdownButton(
      value: feeling,
      dropdownColor: backColor,
      onChanged: (value) => updateFeeling(value!),
      items: [
        dropItem("hoppy", FontAwesomeIcons.faceSmile, "Hop hop Hoooppyyy"),
        dropItem("angry", FontAwesomeIcons.faceAngry, "Trop vénère de Fou"),
        dropItem("neutral", FontAwesomeIcons.faceMeh, "Rien en particulier"),
        dropItem(
            "sad", FontAwesomeIcons.faceSadTear, "Trop triste of the Dead"),
      ],
    );
  }

  DropdownMenuItem dropItem(String value, IconData icon, String feeling) {
    return DropdownMenuItem(
      value: value,
      child: Row(
        children: [
          FaIcon(
            icon,
            color: itemColor,
            size: 25,
          ),
          SizedBox(width: 5),
          Text(
            feeling,
            style: TextStyle(
              color: itemColor,
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}
