import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/entry.dart';

Future<List<Entry>?> getEntries(User? user) async {
  try {
    final db = FirebaseFirestore.instance;

    List<Entry> ret = [];
    final entries = await db
        .collection('entry')
        .where('userID', isEqualTo: user!.uid)
        .get();
    for (var doc in entries.docs) {
      ret.add(Entry.fromDocFirestore(doc));
    }
    return (ret);
  } catch (_) {
    return null;
  }
}
