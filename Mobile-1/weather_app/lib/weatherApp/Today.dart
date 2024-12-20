import 'package:flutter/material.dart';

class Today extends StatefulWidget {
  final String location;

  Today({
    Key? key,
    required this.location,
  }) : super(key: key);
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  late String location;

  @override
  void initState() {
    super.initState();
    location = widget.location;
  }

  @override
  void didUpdateWidget(covariant Today oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.location != widget.location) {
      setState(() {
        location = widget.location;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Today", style: TextStyle(fontSize: 24)),
          Text(location, style: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
