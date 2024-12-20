import 'package:flutter/material.dart';

import '../models/entry.dart';
import 'entry_tile.dart';

class ListOfEntries extends StatefulWidget {
  final void Function() updateList;
  final List<Entry> entries;
  final bool condition;
  const ListOfEntries({
    super.key,
    required this.updateList,
    required this.entries,
    required this.condition,
  });

  @override
  State<ListOfEntries> createState() => _ListOfEntriesState();
}

class _ListOfEntriesState extends State<ListOfEntries> {
  late List<Entry> _entries;
  late bool _condition = true;

  @override
  void initState() {
    super.initState();
    _entries = widget.entries;
    _condition = widget.condition;
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
    return SizedBox(
      height: 295,
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: (_condition)
            ? _entries.length
            : (_entries.length > 2)
                ? 2
                : _entries.length,
        itemBuilder: (context, index) => EntryTile(
          item: _entries[index],
          updateList: widget.updateList,
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 2,
        ),
      ),
    );
  }
}
