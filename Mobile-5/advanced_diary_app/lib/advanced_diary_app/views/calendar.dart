import 'package:diary_app/advanced_diary_app/widgets/user_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../api/db_get_entries.dart';
import '../enums/login_state.dart';
import '../models/entry.dart';
import '../widgets/list_of_entries.dart';

class Calendar extends StatefulWidget {
  final LoginState provider;
  const Calendar({super.key, required this.provider});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  User? user = FirebaseAuth.instance.currentUser;
  DateTime _focusDate = DateTime.now();
  late List<Entry>? _entries = [];
  late List<Entry>? _focusEntries = [];

  void selectDay(DateTime selection) {
    setState(() {
      _focusDate = selection;
    });
    _updateEntries();
  }

  void _updateEntries() async {
    final List<Entry>? data = await getEntries(user);
    data!.sort((a, b) => b.getCreatedAt()!.compareTo(a.getCreatedAt()!));
    setState(() {
      _entries = data;
    });
    _focusEntries = _entries!
        .where((entry) => entry.getCreatedAt()!.day == _focusDate.day)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _focusDate = DateTime.now();
    _updateEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor:
              const Color.fromARGB(255, 36, 13, 187).withOpacity(0.5),
          title: UserAppbar(
            provider: widget.provider,
          )),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/background_feerique_1.png'),
              ),
            ),
          ),
          Column(
            children: [
              _customCalendar(),
              const SizedBox(height: 14),
              ListOfEntries(
                updateList: _updateEntries,
                entries: _focusEntries!,
                condition: true,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _customCalendar() {
    Color primary = Colors.white;
    Color secondary = Colors.pink;
    double dftHeight = 50;
    double dftFontSize = 22;

    return Container(
      color: const Color.fromARGB(255, 0, 103, 177).withOpacity(0.8),
      child: TableCalendar(
        firstDay: DateTime(1900, 1, 1),
        lastDay: DateTime(2200, 12, 31),
        focusedDay: _focusDate,
        currentDay: _focusDate,
        onFormatChanged: (format) => {},
        onDaySelected: (selectedDay, focusedDay) => {
          selectDay(selectedDay),
        },
        rowHeight: dftHeight,
        daysOfWeekHeight: dftHeight,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleTextStyle: TextStyle(
            color: primary,
            fontSize: dftFontSize,
          ),
          leftChevronIcon: Icon(Icons.chevron_left, color: primary),
          rightChevronIcon: Icon(Icons.chevron_right, color: primary),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: primary, fontSize: dftFontSize),
          weekendStyle: TextStyle(color: secondary, fontSize: dftFontSize),
        ),
        calendarStyle: CalendarStyle(
          defaultTextStyle: TextStyle(color: primary, fontSize: dftFontSize),
          weekendTextStyle: TextStyle(color: secondary, fontSize: dftFontSize),
          selectedTextStyle: TextStyle(color: primary, fontSize: dftFontSize),
          todayDecoration:
              BoxDecoration(color: secondary, shape: BoxShape.circle),
          todayTextStyle: TextStyle(
            color: primary,
            fontSize: dftFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
