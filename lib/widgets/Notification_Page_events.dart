
import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/models/eventclass.dart';
import 'package:eventbuzz/services/database.dart';
import 'package:eventbuzz/services/upcoming_event_list.dart';
import 'package:eventbuzz/services/upcoming_eventtile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../services/notification_tile.dart';
import '../services/ongoing_eventtile.dart';
class Notification_Page_events extends StatefulWidget {
  final String message;
  Notification_Page_events(this.message);
  @override
  State<Notification_Page_events> createState() => _Notification_Page_eventsState();
}

class _Notification_Page_eventsState extends State<Notification_Page_events> {
  String name = "";
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
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('events')
                      .snapshots(),
                  builder: (context, snapshots) {
                    int count = 0;

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
                          int flag=0;
                          DateTime sdt = DateTime.parse(stm);
                          DateTime edt = DateTime.parse(etm);
                          Duration diff = sdt.difference(now);
                          var temp = json.decode(events[index].list1);
                          temp.forEach((element) {
                            if(element.toString()==FirebaseAuth.instance.currentUser!.uid)
                            {
                              flag=1;
                            }
                          });



                          if (flag==1 && diff.inMinutes<60 && diff.inMinutes>0 && events[index].flag1==1 && sdt.compareTo(now) > 0 && (events[index].name.toString().toLowerCase().startsWith(name.toLowerCase())||
                              events[index].venue.toString().toLowerCase().startsWith(name.toLowerCase()))) {
                            count = 1;
                            return Notification_Tile(events[index],diff.inMinutes);
                            // index++;
                          }
                          else if(count == 0 && index == events.length-1)
                          {
                            return Center(
                              child: Text('No Notifications'),
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
}