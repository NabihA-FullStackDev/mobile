import 'package:flutter/material.dart';

import '../models/entry.dart';
import 'entry_tile.dart';

class ListOfEntries extends StatefulWidget {
  final void Function() updateList;
  final List<Entry> entries;
  const ListOfEntries(
      {super.key, required this.updateList, required this.entries});

  @override
  State<ListOfEntries> createState() => _ListOfEntriesState();
}

class _ListOfEntriesState extends State<ListOfEntries> {
  late List<Entry> _entries;

  @override
  void initState() {
    super.initState();
    _entries = widget.entries;
  }

  @override
  void didUpdateWidget(covariant ListOfEntries oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entries != widget.entries) {
      _entries = widget.entries;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: _entries.length,
        itemBuilder: (context, index) => EntryTile(
          item: _entries[index],
          updateList: widget.updateList,
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: 2,
        ),
      ),
    );
  }
}
