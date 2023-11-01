import 'package:eventbuzz/pages/login_register_page1.dart';
import 'package:eventbuzz/widgets/admin_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eventbuzz/auth.dart';

class WidgetTree1 extends StatefulWidget {
  const WidgetTree1({Key? key}) : super(key: key);

  @override
  State<WidgetTree1> createState() => _WidgetTree1State();
}

class _WidgetTree1State extends State<WidgetTree1> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          if(FirebaseAuth.instance.currentUser?.uid == 'SOu5KbuBKBOnNImyQihTHl94FUw1') {
            return Admin_home();
          }
          else
          {
            return const LoginPage1();
          }
        }
        else {
          return const LoginPage1();
        }
      },
    );
  }
}
