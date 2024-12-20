import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> deleteEntry(User? user, String id) async {
  try {
    final db = FirebaseFirestore.instance;

    await db.collection('entry').doc(id).delete();
    return true;
  } catch (_) {
    return false;
  }
}
