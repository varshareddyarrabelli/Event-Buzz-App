import 'package:eventbuzz/services/database.dart';
import 'package:eventbuzz/services/exportcsv.dart';
import 'package:eventbuzz/widget_tree1.dart';
import 'package:eventbuzz/widgets/club_heads.dart';
import 'package:eventbuzz/widgets/head_notification.dart';
import 'package:eventbuzz/widgets/sports_heads.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'models/clubclass.dart';
import 'widgets/clubs.dart';
import 'package:flutter/material.dart';
import 'widgets/Home.dart';
import 'widgets/login.dart';
import 'widgets/Clubhome.dart';
import 'widgets/sports.dart';
import 'widgets/sporthome.dart';
import 'widgets/Clubhead_home.dart';
import 'widgets/createevent.dart';
import 'widgets/editevent.dart';
import 'widgets/EventViewPage.dart';
import 'widgets/admin_home.dart';
import 'widgets/add_club.dart';
import 'widgets/view_cs.dart';
import 'widgets/view_clubs.dart';
import 'widgets/view_sports.dart';
import 'widgets/edit_club.dart';
import 'widgets/edit_sports.dart';
import 'widgets/viewcsheads.dart';
import 'widgets/venue_master.dart';
import 'widgets/add_venue.dart';
import 'widgets/requests.dart';
import 'services/exportcsv.dart';
import 'package:eventbuzz/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamProvider<List<Clubs>>.value(
        value: DatabaseService().clubs,
    initialData: [],
    child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final clubs = Provider.of<List<Clubs>>(context);
          if(snapshot.hasError)
          {
            return Text(snapshot.error.toString());
          }
          else if(snapshot.connectionState==ConnectionState.active)
          {
            if(snapshot.data == null)
            {
              return LoginScreen();
            }
            if(snapshot.data!.providerData.any(
                  (userInfo) => userInfo.providerId == "password",
            ))
            {
            if(FirebaseAuth.instance.currentUser?.uid == 'hlFSlRvoeMOoOYaDyuoyLOxkU3n2') {
              for(var index = 0; index < clubs.length ; index++) {
                if(clubs[index].headmail == FirebaseAuth.instance.currentUser?.email) {

                  return Clubhead_home(
                      FirebaseAuth.instance.currentUser?.email,clubs[index].name);
                }
              }
              return Card();
            }
              else if(FirebaseAuth.instance.currentUser?.uid == 'gIbjzTKpEkc3GTmxmWrZuFhetem1') {
                for(var index = 0; index < clubs.length ; index++) {
                  if(clubs[index].headmail == FirebaseAuth.instance.currentUser?.email) {
                    return Clubhead_home(
                        FirebaseAuth.instance.currentUser?.email,clubs[index].name);
                  }
                }
                return Card();
              }
              else if(FirebaseAuth.instance.currentUser?.uid == 'mz5nGlSFxkVK7cFXvhSMnlyyvlZ2') {
                for(var index = 0; index < clubs.length ; index++) {
                  if(clubs[index].headmail == FirebaseAuth.instance.currentUser?.email) {

                    return Clubhead_home(
                        FirebaseAuth.instance.currentUser?.email,clubs[index].name);
                  }
                }
                return Card();
              }
              else if(FirebaseAuth.instance.currentUser?.uid == 'dF9XArLzsVSLMbcOtNrXYpYejlz2')
                {
                  return Clubhead_home(FirebaseAuth.instance.currentUser?.email, 'Kabaddi'); //m@gmail.com
                }
            else if(FirebaseAuth.instance.currentUser?.uid == 'grWjg4Zz3md8mRHm2rLnONFOarB3')
            {
              return Clubhead_home(FirebaseAuth.instance.currentUser?.email, 'Kho Kho'); // b@gmail.com
            }
              else if(FirebaseAuth.instance.currentUser?.uid == 'SOu5KbuBKBOnNImyQihTHl94FUw1') {
                return Admin_home();
              }
            }
            else
            {
              return Home();
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      ),
      routes: {
        // '/': (BuildContext context) => LoginScreen(),
        '/home': (context) => Home(),
        '/clubs': (context) => ClubPage(),
        '/sports': (context) => SportPage(),
        '/club_heads': (context) => club_heads(),
        '/sports_heads': (context) => sports_heads(),
        // '/clubhome': (context) => Clubhome('club'),
        // '/sporthome': (context) => Sporthome(),
        // '/Clubhead_home': (context) => Clubhead_home(),
        // '/createevent': (context) => createevent(),
        // '/editevent': (context) => editevent(),
        // '/viewevent': (context) => viewevent(),
        '/widget_tree': (context) => WidgetTree(),
        '/admin_home': (context)=>Admin_home(),
        '/addclub': (context)=>Add_club(),
        '/view_CS': (context)=>View_cs(),
        '/view_clubs': (context)=>view_clubs(),
        '/view_sports': (context)=>view_sports(),
        // '/editclub': (context)=>Edit_club(),
        // '/editsports': (context)=>Edit_sports(),
        '/csheads' : (context)=>csheads(),
        '/venue_master' : (context)=>vvenues(),
        '/add_venue' : (context)=>Add_venue(),
        '/requests' : (context)=>Request(),
        '/login': (context)=>LoginScreen(),
        '/headnotif': (context)=>head_notification(),
        '/widget_tree1': (context)=>WidgetTree1(),
        // '/exportcsv' : (context)=>ExportCsv(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
