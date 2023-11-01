import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/clubclass.dart';
import '../services/clublist.dart';
import '../services/database.dart';
import '../services/viewclubtile.dart';
import 'view_liked_clubs.dart';
import 'view_liked_events.dart';
import 'Past_Events.dart';
import 'Ongoing_Events.dart';
import 'Upcoming_Events.dart';
class ClubPage extends StatefulWidget {
  @override
  _ClubPageState createState() => _ClubPageState();
}
String name = "";
class _ClubPageState extends State<ClubPage> {
  final List<Event> _clubEvents = [
    Event(name: 'Adventure', venue: 'ELHC 403'),
  ];

  List<Event> _filteredEvents = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _filteredEvents = _clubEvents;
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Clubs>>.value(
        value : DatabaseService().clubs,
    initialData: [],
    child :Scaffold(
      appBar: AppBar(
        title: Text('Club Events'),
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
              final clubs = Provider.of<List<Clubs>>(context);
              return (snapshots.connectionState ==
                  ConnectionState.waiting) ?
              Center(
                child: CircularProgressIndicator(),
              ) : SingleChildScrollView(
                physics: ScrollPhysics(),
                child:ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: clubs.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index)
                  {
                    if((clubs[index].name.toString().toLowerCase().startsWith(name.toLowerCase())))
                    {
                    return ClubTile1(clubs[index]);
                    }
                    else
                      {
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

  void _filterEvents(String query) {
    setState(() {
      _filteredEvents = _clubEvents
          .where((event) =>
      event.name.toLowerCase().contains(query.toLowerCase()) ||
          event.venue.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}

class Event {
  final String name;
  final String venue;


  Event({required this.name, required this.venue});
}
