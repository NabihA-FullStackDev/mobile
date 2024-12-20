import 'package:diary_app/advanced_diary_app/utils/get_feeling.dart';
import 'package:flutter/material.dart';

import '../models/entry.dart';

class ListEmotions extends StatefulWidget {
  final List<Entry>? entries;
  const ListEmotions({super.key, required this.entries});

  @override
  State<ListEmotions> createState() => _ListEmotionsState();
}

class _ListEmotionsState extends State<ListEmotions> {
  late List<Entry> _entries;
  final List<String> emotions = ["hoppy", "angry", "neutral", "sad"];
  final List<String> emotionsText = [
    "Hop hop Hoppity",
    "Trop vénère de Fou",
    "Rien en particulier",
    "Trop triste of the Dead",
  ];

  void updateEntries() {
    setState(() {
      _entries = widget.entries ?? [];
    });
  }

  double updateEmotionPercent(String emotion) {
    double n = 0;

    if (_entries.isNotEmpty) {
      n = (_entries.where((entry) => entry.getFeeling() == emotion).length /
              _entries.length *
              100)
          .roundToDouble();
    }
    return (n.roundToDouble());
  }

  @override
  void initState() {
    super.initState();
    updateEntries();
  }

  @override
  void didUpdateWidget(covariant ListEmotions oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entries != widget.entries) {
      updateEntries();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color.fromARGB(255, 0, 103, 177).withOpacity(0.8),
        ),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: emotions.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const Text(
                textAlign: TextAlign.center,
                "Vos émotions",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              );
            } else {
              return _listTileEmotion(index - 1);
            }
          },
          separatorBuilder: (context, _) => const Divider(),
        ),
      ),
    );
  }

  Widget _listTileEmotion(int index) {
    Color item = Colors.white;

    return ListTile(
      leading: Icon(
        size: 42,
        color: item,
        getFeeling(emotions[index]),
      ),
      title: Text(
        textAlign: TextAlign.left,
        "${emotionsText[index]}:",
        style: TextStyle(fontSize: 23, color: item),
      ),
      trailing: Text(
        "${updateEmotionPercent(emotions[index])} %",
        style:
            TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: item),
      ),
    );
  }
}
