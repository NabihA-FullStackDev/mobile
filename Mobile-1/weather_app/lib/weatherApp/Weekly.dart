import 'package:flutter/material.dart';

class Weekly extends StatefulWidget {
  final String location;

  Weekly({
    Key? key,
    required this.location,
  }) : super(key: key);
  @override
  _WeeklyState createState() => _WeeklyState();
}

class _WeeklyState extends State<Weekly> {
  late String location;

  @override
  void initState() {
    super.initState();
    location = widget.location;
  }

  @override
  void didUpdateWidget(covariant Weekly oldWidget) {
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
          const Text("Weekly", style: TextStyle(fontSize: 24)),
          Text(location, style: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
