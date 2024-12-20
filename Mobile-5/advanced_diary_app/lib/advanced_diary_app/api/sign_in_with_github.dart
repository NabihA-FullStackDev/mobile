import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential?> signInWithGitHub() async {
  try {
    GithubAuthProvider githubProvider = GithubAuthProvider();

    return await FirebaseAuth.instance.signInWithProvider(githubProvider);
  } catch (e) {
    return null;
  }
}
