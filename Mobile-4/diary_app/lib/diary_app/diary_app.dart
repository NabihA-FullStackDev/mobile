import 'package:diary_app/diary_app/views/login.dart';
import 'package:diary_app/diary_app/views/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'enums/login_state.dart';

class MyLittleDiary extends StatefulWidget {
  const MyLittleDiary({super.key});

  @override
  State<MyLittleDiary> createState() => _MyLittleDiaryState();
}

class _MyLittleDiaryState extends State<MyLittleDiary> {
  LoginState _lstate = LoginState.notLogin;

  @override
  void initState() {
    super.initState();
    _changeLoginState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'GreatVibes',
        scaffoldBackgroundColor: const Color.fromARGB(255, 36, 13, 187),
      ),
      home: _getBody(),
    );
  }

  Widget _getBody() {
    switch (_lstate) {
      case LoginState.withGoogle || LoginState.withGithub:
        return ProfilePage(
          provider: _lstate,
        );
      default:
        return LoginPage(loginStater: _changeLoginState);
    }
  }

  void _changeLoginState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          _lstate = LoginState.notLogin;
        });
      } else {
        if (user.providerData.first.providerId.toString() == "google.com") {
          setState(() {
            _lstate = LoginState.withGoogle;
          });
        } else {
          setState(() {
            _lstate = LoginState.withGithub;
          });
        }
      }
    });
  }
}
