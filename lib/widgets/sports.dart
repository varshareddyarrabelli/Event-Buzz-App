import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/clubclass.dart';
import '../models/sportclass.dart';
import '../services/clublist.dart';
import '../services/database.dart';
import '../services/viewclubtile.dart';
import '../services/viewsporttile1.dart';
import 'view_liked_clubs.dart';
import 'view_liked_events.dart';
import 'Past_Events.dart';
import 'Ongoing_Events.dart';
import 'Upcoming_Events.dart';
class SportPage extends StatefulWidget {
  @override
  _SportPageState createState() => _SportPageState();
}
String name = "";
class _SportPageState extends State<SportPage> {


  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Sports>>.value(
      value: DatabaseService().sports,
      initialData: [],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sport Events'),
          centerTitle: true,
          backgroundColor: Color(0xff764abc),
        ),
        body: Column(
          children: [
            Card(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search for club...'),
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('clubs')
                  .snapshots(),
              builder: (context, snapshots) {
                final sports = Provider.of<List<Sports>>(context);
                return (snapshots.connectionState ==
                    ConnectionState.waiting) ?
                Center(
                  child: CircularProgressIndicator(),
                ) : SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: sports.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      if ((sports[index].name.toString()
                          .toLowerCase()
                          .startsWith(name.toLowerCase()))) {
                        return SportTile1(sports[index]);
                      }
                      else {
                        return Card();
                      }
                      // index++;
                    },
                  ),
                );
              },
            ),
            //   Column(children: [
            //     SizedBox(height: 100000, child: Upcoming_EventList())]),
          ],

        ),
      ),

    );
  }

}