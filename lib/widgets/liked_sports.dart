
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eventbuzz/services/liked_eventtile.dart';
import 'package:provider/provider.dart';
import 'dart:core';
import 'dart:convert';
import '../models/clubclass.dart';
import '../models/sportclass.dart';
import '../services/club_liked_eventtile.dart';
import '../services/database.dart';
import '../services/sport_liked_eventtile.dart';
import 'event.dart';
String name = "";
class Liked_Sports extends StatefulWidget {

  final String message;

  Liked_Sports(this.message);
  @override
  State<Liked_Sports> createState() => _Liked_SportsState();
}

class _Liked_SportsState extends State<Liked_Sports> {

  List<event> _filteredEvents = [];
  List<event> events=[
    event('Robo','Vhawdd','1as0','asa11','asadh'),
    event('Roboad','Vhaffd','1as0','asa11','asadh'),
    event('Roboads','Vhawdwd','1as0','asa11','asadh'),
    event('Roboadsd','Vhawd','1as0','asa11','asadh'),
    event('Robocd','Vhadfww','1as0','asa11','asadh'),
  ];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _filteredEvents = events;
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Sports>>.value(
        value: DatabaseService().sports,
        initialData: [],
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 5,),
                Text(widget.message,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                SizedBox(height: 5,),
                Card(
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search for title...'),
                    onChanged: (val) {
                      setState(() {
                        name = val;
                      });
                    },
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('sports')
                      .snapshots(),
                  builder: (context, snapshots) {
                    int count = 0;

                    final sports = Provider.of<List<Sports>>(context);
                    return (snapshots.connectionState ==
                        ConnectionState.waiting) ?
                    Center(
                      child: CircularProgressIndicator(),
                    ) : SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child:ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: sports.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index)
                        {
                          int flag =0;
                          var temp = json.decode(sports[index].list1);
                          temp.forEach((element) {
                            if(element.toString()==FirebaseAuth.instance.currentUser!.uid)
                            {
                              flag=1;
                            }
                          });
                          if(flag==1 && (sports[index].name.toString().toLowerCase().startsWith(name.toLowerCase()))) {
                            count = 1;
                            return sport_liked_eventtile(sport: sports[index]);
                          }
                          else if(count == 0 && index == sports.length-1)
                          {
                            return Center(
                              child: Text('No Events Found'),
                            );
                          }
                          else
                          {
                            return Card();
                          }
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

        )

    );
  }

  void _filterEvents(String query) {
    setState(() {
      _filteredEvents = events.where((event) =>
      event.name!.toLowerCase().contains(query.toLowerCase()) ||
          event.venue!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}

Widget eventtemplate (event, BuildContext context)
{
  return Card(

      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: new InkWell(
        onTap: (){
          Navigator.pushNamed(context, '/viewevent');
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 10,),
                    Text(
                        event.name,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    SizedBox(width: 10,),
                    Text(
                        event.venue,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )
                    ),
                    SizedBox(width: 10,),
                    Text(
                        event.timings,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )
                    ),
                    SizedBox(width: 10,),
                    Text(
                        event.date,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/slider2.jpeg'),
                      radius: 40.0,
                    ),
                  ],
                ),
              ) ,
            ],
          ),
        ),
      )
  );
}