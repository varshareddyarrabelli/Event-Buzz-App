import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/services/club_upcoming_event_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'event.dart';
import 'package:eventbuzz/models/eventclass.dart';
import 'package:eventbuzz/services/database.dart';
import 'package:eventbuzz/services/upcoming_eventtile.dart';
String name = "";
class Upcoming_Clubpage extends StatefulWidget {

  final String message;
  final String name;

  Upcoming_Clubpage(this.message,this.name);
  @override
  State<Upcoming_Clubpage> createState() => _Upcoming_ClubpageState();
}

class _Upcoming_ClubpageState extends State<Upcoming_Clubpage> {
  _getDateTime() {
    setState(() {
      now = DateTime.now();
    });
  }
  @override
  void initState() {
    _getDateTime();
    super.initState();
    Timer.periodic(Duration(seconds: 60), (_) => _getDateTime());
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
                        hintText: 'Search'),
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
                  builder: (context, snapshots) {int count =0;

                  final events = Provider.of<List<Events>>(context);
                  events.sort((a,b)=>DateTime.parse(a.dtt).compareTo(DateTime.parse(b.dtt)));
                    return (snapshots.connectionState ==
                        ConnectionState.waiting) ?
                    Center(
                      child: CircularProgressIndicator(),
                    ) :  SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child:ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                      itemCount: events.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final String stm, etm;
                        stm =
                            events[index].date + ' ' + events[index].starttime;
                        etm = events[index].date + ' ' + events[index].endtime;

                        DateTime sdt = DateTime.parse(stm);
                        DateTime edt = DateTime.parse(etm);
                        if (events[index].flag1==1 && events[index].clubname == widget.name && sdt.compareTo(now) > 0 && (events[index].name
                            .toString().toLowerCase().startsWith(name
                            .toLowerCase()) ||
                            events[index].venue.toString()
                                .toLowerCase()
                                .startsWith(name.toLowerCase()))) {
                          count = 1;
                          return Upcoming_EventTile(event: events[index]);
                          // index++;
                        }
                        else if (count == 0 && index == events.length - 1) {
                          return Center(
                            child: Text('No Events Found'),
                          );
                        }
                        else {
                          return SizedBox(height: 0,width: 0,);
                        }
                      },
                    ),
                    );
                  },
                ),
              ],

            ),
          ),

        )

    );
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