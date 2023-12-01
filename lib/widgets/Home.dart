import 'dart:async';
import 'package:eventbuzz/auth.dart';
import 'package:eventbuzz/widgets/liked_sports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eventbuzz/widgets/login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Notification_Page_events.dart';
import 'view_liked_clubs.dart';
import 'view_liked_events.dart';
import 'Past_Events.dart';
import 'Ongoing_Events.dart';
import 'Notification_Page.dart';
import 'Upcoming_Events.dart';

class AboutWidget1 extends StatefulWidget {
  @override
  State<AboutWidget1> createState() => _AboutWidget1State();
}

class _AboutWidget1State extends State<AboutWidget1> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Log Out'),
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Are you sure you want to Sign Out'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Sign Out'),
          onPressed: () async {
            await GoogleSignIn().signOut();
            FirebaseAuth.instance.signOut();
            Navigator.popUntil(context, ModalRoute.withName('/'));
            // await Auth().signOut();
          },
        ),
      ],
    );

  }
}


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

final PageController _pageController = PageController();


class _HomeState extends State<Home> {

  int _selectedIndex = 0;
  String selectedType = '';

  final List<String> _accountTypes = [
    'Club 1',
    'Club 2',
  ];
  String selectedType2 = '';

  final List<String> _accountTypes2 = [
    'Sport 1',
    'Sport 2',
  ];


  static final List<Widget> _pages = <Widget>[


    PageView(
      controller: _pageController,
      children: [
        Upcoming_Page('Upcoming Events'),
        Ongoing_Page('Ongoing Events'),
        Past_Page('Past Events'),
      ],
    ),
    PageView(
        children: [
          Notification_Page_events('Favourite Event Notifications'),
          Notification_Page('All Notifications'),
        ]
    ),
    PageView(
      children: [
        Liked_Events('Liked Events'),
        Liked_Clubs('Liked Clubs'),
        Liked_Sports('Liked Sports'),

      ],
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.pink,

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Home Page',
        ),
        backgroundColor: Color(0xff764abc),
          actions: [
            IconButton(
              onPressed: ()=> showDialog(
                context: context,
                builder: (context) => AboutWidget1(),
              ),
              icon:const Icon(Icons.logout),)],
        //backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff764abc),
              ),
              child: Text('CLUBS AND SPORTS',
              style:TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Home'),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => const Home()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.music_note,
              ),
              title: const Text('Clubs'),
              onTap: () {
                Navigator.pushNamed(context,'/clubs');
              },
            ),


            ListTile(
              leading: Icon(
                Icons.sports,
              ),
              title: const Text('Sports'),
              onTap: () {
                Navigator.pushNamed(context,'/sports');
              },
            ),
          ],
        ),
    ),
      body: Stack(
            children: [
              Center(
                child: _pages.elementAt(_selectedIndex),
                ),
            ],
          ),

      bottomNavigationBar: BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
        icon: Icon(Icons.home),
    label: 'Home',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.notifications),
    label: 'Notifications',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.favorite),
    label: 'Favourites',
    )
    ],
    selectedItemColor: Colors.black,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
    );
  }
}

