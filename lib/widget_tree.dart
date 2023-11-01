import 'package:eventbuzz/pages/login_register_page1.dart';
import 'package:eventbuzz/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eventbuzz/auth.dart';
import 'package:eventbuzz/widgets/Clubhead_home.dart';
import 'package:eventbuzz/pages/login_register_page.dart';
import 'package:provider/provider.dart';

import 'models/clubclass.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Clubs>>.value(
        value : DatabaseService().clubs,
    initialData: [],
    child: StreamBuilder(
        stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        final clubs = Provider.of<List<Clubs>>(context);
          if(snapshot.hasData) {
            if(FirebaseAuth.instance.currentUser?.uid == 'gIbjzTKpEkc3GTmxmWrZuFhetem1') {
              for(int index = 0; index<clubs.length;index++)
                {
                  if (clubs[index].headmail == FirebaseAuth.instance.currentUser?.email) {
                    return Clubhead_home(FirebaseAuth.instance.currentUser?.email,clubs[index].name);
                    // index++;
                  }
                }
            }
            else if(FirebaseAuth.instance.currentUser?.uid == 'hlFSlRvoeMOoOYaDyuoyLOxkU3n2') {
              for(var index = 0; index < clubs.length ; index++) {
                if(clubs[index].headmail == FirebaseAuth.instance.currentUser?.email) {
                  return Clubhead_home(
                      FirebaseAuth.instance.currentUser?.email,clubs[index].name);
                }
              }
            }
            else if(FirebaseAuth.instance.currentUser?.uid == 'mz5nGlSFxkVK7cFXvhSMnlyyvlZ2') {
              for(var index = 0; index < clubs.length ; index++) {
                if(clubs[index].headmail == FirebaseAuth.instance.currentUser?.email) {

                  return Clubhead_home(
                      FirebaseAuth.instance.currentUser?.email,clubs[index].name);
                }
              }
            }
            else if(FirebaseAuth.instance.currentUser?.uid == 'dF9XArLzsVSLMbcOtNrXYpYejlz2')
            {
              return Clubhead_home(FirebaseAuth.instance.currentUser?.email, 'Kabaddi');
            }
            else if(FirebaseAuth.instance.currentUser?.uid == 'grWjg4Zz3md8mRHm2rLnONFOarB3')
            {
              return Clubhead_home(FirebaseAuth.instance.currentUser?.email, 'Kho Kho'); // b@gmail.com
            }
            else
              {
                return const LoginPage();
              }
            return Card();
          }
          else {
            return const LoginPage();
          }
      },
    ),
    );
  }
}
