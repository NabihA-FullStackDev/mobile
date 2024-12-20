import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> signOutWithGoogle() async {
  try {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  } catch (_) {
    return;
  }
}
