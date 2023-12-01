import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/services/liked_eventtile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/eventclass.dart';
import '../services/database.dart';
import '../services/ongoing_eventtile.dart';
import '../services/upcoming_eventtile.dart';
import 'event.dart';
String name="";
class Liked_Events extends StatefulWidget {

  final String message;

  Liked_Events(this.message);
  @override
  State<Liked_Events> createState() => _Liked_EventsState();
}

class _Liked_EventsState extends State<Liked_Events> {

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

    return StreamProvider<List<Events>>.value(
        value: DatabaseService().events,
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
                  stream: FirebaseFirestore.instance.collection('events')
                      .snapshots(),
                  builder: (context, snapshots) {
                    int count=0;

                    final events = Provider.of<List<Events>>(context);
                    return (snapshots.connectionState ==
                        ConnectionState.waiting) ?
                    Center(
                      child: CircularProgressIndicator(),
                    ) : SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child:ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: events.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index)
                        {

                          final String stm, etm;
                          stm = events[index].date + ' ' + events[index].starttime;
                          etm = events[index].date + ' ' + events[index].endtime;

                          DateTime sdt = DateTime.parse(stm);
                          DateTime edt = DateTime.parse(etm);
                          int flag =0;
                          var temp = json.decode(events[index].list1);
                          temp.forEach((element) {
                            if(element.toString()==FirebaseAuth.instance.currentUser!.uid)
                              {
                                flag=1;
                              }
                          });
                              if(flag==1 && (events[index].name.toString().toLowerCase().startsWith(name.toLowerCase())||
                                  events[index].venue.toString().toLowerCase().startsWith(name.toLowerCase()))) {
                                count = 1;
                                return liked_eventtile(event: events[index]);
                              }
                              else if(count == 0 && index == events.length-1)
                              {
                                return Center(
                                  child: Text('No Events Found'),
                                );
                              }
                              else
                              {
                                return SizedBox(height: 0,width: 0,);
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