import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/clubclass.dart';
import 'EventViewPage1.dart';
import 'view_liked_clubs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';
import 'view_liked_events.dart';
import 'Past_Clubpage.dart';
import 'Ongoing_Clubpage.dart';
import 'Upcoming_Clubpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Clubhome extends StatefulWidget {

  final Clubs club;

  Clubhome( this.club);
  // const Clubhome({Key? key}) : super(key: key);
  @override
  State<Clubhome> createState() => _ClubhomeState();
}
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
}
final PageController _pageController = PageController();

class _ClubhomeState extends State<Clubhome> {


  int _selectedIndex = 0;
  String selectedType = '';

  String selectedType2 = '';

  // static final List<Widget> _pages = <Widget>[
  //   PageView(
  //     controller: _pageController,
  //     children: [
  //       Upcoming_Clubpage('Upcoming Events'),
  //       Ongoing_Clubpage('Ongoing Events'),
  //       Past_Clubpage('Past Events'),
  //     ],
  //   ),
  //   Icon(
  //     Icons.notifications,
  //     size: 150,
  //   ),
  //   PageView(
  //     children: [
  //       Liked_Clubs('Liked Clubs'),
  //       Liked_Events('Liked Events'),
  //     ],
  //   ),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.club.name,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),),
        backgroundColor: const Color(0xff764abc),
          actions: [
            IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => viewevent1(
                          widget.club
                      )),
                );
              },
              icon:const Icon(Icons.info_outline),)]
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
                ),),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Home'),
              onTap: () {
                Navigator.pushNamed(context,'/home');
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
            child: PageView(
              controller: _pageController,
              children: [
                Upcoming_Clubpage('Upcoming Events',widget.club.name),
                Ongoing_Clubpage('Ongoing Events',widget.club.name),
                Past_Clubpage('Past Events',widget.club.name),
              ],
            ),
          ),
          // ),
        ],
      ),
    floatingActionButton: FloatingActionButton(
       onPressed: () {
         dynamic temp = json.decode(widget.club.list1);
         temp.insert(0, FirebaseAuth.instance.currentUser!.uid);
         String temp2 = json.encode(temp);
         final docuser = FirebaseFirestore.instance.collection('clubs').doc(widget.club.id);
         docuser.update(
             {
               'list1':temp2,
             }
         );
       },
      child: Icon(Icons.favorite,
        color: Colors.redAccent,
      ),
        backgroundColor: Colors.redAccent[100],
    ),

    );
  }
}

