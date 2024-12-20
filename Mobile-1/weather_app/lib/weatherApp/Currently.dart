import 'package:flutter/material.dart';

class Currently extends StatefulWidget {
  final String location;

  Currently({
    Key? key,
    required this.location,
  }) : super(key: key);
  @override
  _CurrentlyState createState() => _CurrentlyState();
}

class _CurrentlyState extends State<Currently> {
  late String location;

  @override
  void initState() {
    super.initState();
    location = widget.location;
  }

  @override
  void didUpdateWidget(covariant Currently oldWidget) {
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
          const Text("Currently", style: TextStyle(fontSize: 24)),
          Text(location, style: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
