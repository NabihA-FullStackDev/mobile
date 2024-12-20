import 'package:diary_app/diary_app/api/sign_in_with_github.dart';
import 'package:flutter/material.dart';

import '../api/sign_in_with_google.dart';

class LoginPage extends StatelessWidget {
  final void Function() loginStater;
  const LoginPage({
    super.key,
    required this.loginStater,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/background_diary.png"),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _customElevatedButton('Google', signInWithGoogle),
            SizedBox(
              height: 14,
              width: 14,
            ),
            _customElevatedButton('Github', signInWithGitHub),
          ],
        ),
      ),
    );
  }

  Widget _customElevatedButton(
    String name,
    dynamic Function() signInFunc,
  ) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.all(14)),
        backgroundColor: WidgetStatePropertyAll(
          const Color.fromARGB(255, 36, 13, 187).withOpacity(0.9),
        ),
      ),
      onPressed: () async => {
        signInFunc(),
        loginStater(),
      },
      child: Text(
        "Se connecter\navec $name",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
