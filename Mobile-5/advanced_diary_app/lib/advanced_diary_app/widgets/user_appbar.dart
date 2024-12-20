import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../api/sign_out_with_github.dart';
import '../api/sign_out_with_google.dart';
import '../enums/login_state.dart';

class UserAppbar extends StatefulWidget {
  final LoginState provider;
  const UserAppbar({
    super.key,
    required this.provider,
  });

  @override
  State<UserAppbar> createState() => _UserAppbarState();
}

class _UserAppbarState extends State<UserAppbar> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Color itemColor = Colors.white;

    return AppBar(
      backgroundColor: Colors.white.withOpacity(0),
      centerTitle: true,
      title: Container(
        padding: const EdgeInsets.only(top: 12),
        child: Text(
          textAlign: TextAlign.center,
          user!.displayName.toString(),
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: itemColor,
          ),
        ),
      ),
      flexibleSpace: Container(
        width: 46,
        height: 46,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: itemColor,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(user!.photoURL.toString()),
          ),
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.only(
            top: 10,
            right: 10,
          ),
          child: IconButton(
            onPressed: () async => {
              (widget.provider == LoginState.withGoogle)
                  ? await signOutWithGoogle()
                  : await signOutWithGithub()
            },
            icon: FaIcon(
              FontAwesomeIcons.rightFromBracket,
              color: itemColor,
            ),
          ),
        ),
      ],
    );
  }
}
