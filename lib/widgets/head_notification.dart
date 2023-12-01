
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/models/eventclass.dart';
import 'package:eventbuzz/models/feed.dart';
import 'package:eventbuzz/services/database.dart';
import 'package:eventbuzz/services/upcoming_event_list.dart';
import 'package:eventbuzz/services/upcoming_eventtile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../services/head_notificationtile.dart';
import '../services/head_notificationtile1.dart';
import '../services/notification_tile.dart';
import '../services/ongoing_eventtile.dart';
String name = "";
class head_notification extends StatefulWidget {
  @override
  State<head_notification> createState() => _head_notificationState();
}

class _head_notificationState extends State<head_notification> {
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
    return StreamProvider<List<Feeds>>.value(
        value: DatabaseService().feeds,
        initialData: [],
        child: Scaffold(
          appBar: AppBar(
            title: Text('Notifications',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [

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
                SizedBox(height: 5,),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('feeds')
                      .snapshots(),
                  builder: (context, snapshots) {
                    int count = 0;

                    final feeds = Provider.of<List<Feeds>>(context);
                    feeds.sort((a,b)=>DateTime.parse(a.dtt).compareTo(DateTime.parse(b.dtt)));
                    return (snapshots.connectionState ==
                        ConnectionState.waiting) ?
                    Center(
                      child: CircularProgressIndicator(),
                    ) : SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child:ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: feeds.length,
                        reverse: true,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index)
                        {
                          if (feeds[index].flag==0 && feeds[index].mail == FirebaseAuth.instance.currentUser?.email &&
                              feeds[index].name.toString().toLowerCase().startsWith(name.toLowerCase())) {
                            count = 1;
                            return head_notificationtile(feeds[index]);
                            // index++;
                          }
                          else if (feeds[index].flag==1 && feeds[index].mail == FirebaseAuth.instance.currentUser?.email &&
                              feeds[index].name.toString().toLowerCase().startsWith(name.toLowerCase())) {
                            count = 1;
                            return head_notificationtile1(feeds[index]);
                            // index++;
                          }
                          else if(count == 0 && index == feeds.length-1)
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