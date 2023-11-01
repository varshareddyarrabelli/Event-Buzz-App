
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/models/eventclass.dart';
import 'package:eventbuzz/services/database.dart';
import 'package:eventbuzz/services/upcoming_event_list.dart';
import 'package:eventbuzz/services/upcoming_eventtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
class Upcoming_Page extends StatefulWidget {
  final String message;
  Upcoming_Page(this.message);
  @override
  State<Upcoming_Page> createState() => _Upcoming_PageState();
}

class _Upcoming_PageState extends State<Upcoming_Page> {
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
                Card(

                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search by name or venue'),
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
                    int count = 0;
                    final events = Provider.of<List<Events>>(context);
                    events.sort((a,b)=>DateTime.parse(a.dtt).compareTo(DateTime.parse(b.dtt)));
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
                        print(sdt);
                        if (events[index].flag1==1 && sdt.compareTo(now) > 0 && (events[index].name.toString().toLowerCase().startsWith(name.toLowerCase())||
                            events[index].venue.toString().toLowerCase().startsWith(name.toLowerCase()))) {
                          count = 1;
                          return Upcoming_EventTile(event: events[index]);
                          // index++;
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
}