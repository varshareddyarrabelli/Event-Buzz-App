import 'package:eventbuzz/widgets/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eventbuzz/widgets/Home.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(),);
          else if(snapshot.hasData) {
            return Home();
          }
          else if(snapshot.hasError) {
            return Center(child: Text('Something Went Wrong'),);
          }
          else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
