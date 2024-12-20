import 'package:firebase_auth/firebase_auth.dart';

Future<void> signOutWithGithub() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (_) {
    return;
  }
}
