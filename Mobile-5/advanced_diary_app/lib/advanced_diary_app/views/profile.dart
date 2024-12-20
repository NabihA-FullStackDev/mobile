import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../api/db_get_entries.dart';
import '../enums/login_state.dart';
import '../models/entry.dart';
import '../widgets/entry_form.dart';
import '../widgets/list_emotions.dart';
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color itemsColor = Colors.white;
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
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/background_feerique_0.png'),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListOfEntries(
                updateList: _updateEntries,
                entries: _entries ?? [],
                condition: false,
              ),
              Container(
                padding: const EdgeInsets.only(left: 14, right: 14, top: 8),
                child: _containerBordered(
                  Text(
                    textAlign: TextAlign.center,
                    "Vous avez ${_entries!.length} entrée(s)",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: itemsColor,
                    ),
                  ),
                ),
              ),
              ListEmotions(entries: _entries),
              TextButton(
                onPressed: () => _newEntry(context),
                child: _containerBordered(
                  const Text(
                    textAlign: TextAlign.center,
                    "Ajouter une entrée",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: itemsColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _containerBordered(Widget w) {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 36, 13, 187),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          width: 3,
          color: Colors.white,
        ),
      ),
      child: w,
    );
  }
}
