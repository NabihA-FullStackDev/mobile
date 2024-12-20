import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'enums/login_state.dart';
import 'enums/nav_state.dart';
import 'views/login.dart';
import 'views/profile.dart';
import 'views/calendar.dart';
import 'widgets/nav_bar.dart';

class MyLittleDiary extends StatefulWidget {
  const MyLittleDiary({super.key});

  @override
  State<MyLittleDiary> createState() => _MyLittleDiaryState();
}

class _MyLittleDiaryState extends State<MyLittleDiary> {
  LoginState _lState = LoginState.notLogin;
  NavState _nState = NavState.profile;

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
        home: Scaffold(
          body: _getBody(),
          bottomNavigationBar: _getNavBar(),
        ));
  }

  Widget _getBody() {
    switch (_lState) {
      case LoginState.withGoogle || LoginState.withGithub:
        switch (_nState) {
          case NavState.profile:
            return ProfilePage(
              provider: _lState,
            );
          case NavState.calendar:
            return Calendar(
              provider: _lState,
            );
        }
      default:
        _nState = NavState.profile;
        return LoginPage(loginStater: _changeLoginState);
    }
  }

  Widget? _getNavBar() {
    switch (_lState) {
      case LoginState.withGoogle || LoginState.withGithub:
        return CustomNavBar(navStateFunc: _changeNavState);
      default:
        return null;
    }
  }

  void _changeLoginState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          _lState = LoginState.notLogin;
        });
      } else {
        if (user.providerData.first.providerId.toString() == "google.com") {
          setState(() {
            _lState = LoginState.withGoogle;
          });
        } else {
          setState(() {
            _lState = LoginState.withGithub;
          });
        }
      }
    });
  }

  void _changeNavState(NavState newState) {
    setState(() {
      _nState = newState;
    });
  }
}
