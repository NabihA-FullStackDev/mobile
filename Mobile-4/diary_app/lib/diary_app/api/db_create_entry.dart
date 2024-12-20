import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> createEntry(
  User? user,
  String title,
  String text,
  String feeling,
) async {
  try {
    final db = FirebaseFirestore.instance;

    await db.collection('entry').add({
      'createdAt': Timestamp.now(),
      'title': title,
      'text': text,
      'feeling': feeling,
      'email': user!.email,
      'userID': user.uid,
    });
  } catch (_) {
    return;
  }
}
