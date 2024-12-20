import 'package:diary_app/diary_app/enums/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../api/db_get_entries.dart';
import '../models/entry.dart';
import '../widgets/entry_form.dart';
import '../widgets/list_of_entries.dart';
import '../widgets/user_appbar.dart';

class ProfilePage extends StatefulWidget {
  final LoginState provider;
  const ProfilePage({
    super.key,
    required this.provider,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  late List<Entry>? _entries = [];

  void _updateEntries() async {
    final List<Entry>? data = await getEntries(user);
    data!.sort((a, b) => b.getCreatedAt()!.compareTo(a.getCreatedAt()!));
    setState(() {
      _entries = data;
    });
  }

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _updateEntries();
  }

  void _newEntry(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return EntryForm(
            updateEntries: _updateEntries,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor:
              const Color.fromARGB(255, 36, 13, 187).withOpacity(0.5),
          title: UserAppbar(
            provider: widget.provider,
          )),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/background_feerique_0.png'),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListOfEntries(
                updateList: _updateEntries,
                entries: _entries ?? [],
              ),
              TextButton(
                onPressed: () => _newEntry(context),
                child: Text(
                  "Ajouter une entrée",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
