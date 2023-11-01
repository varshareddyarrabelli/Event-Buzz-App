import 'package:eventbuzz/models/eventclass.dart';
import 'package:eventbuzz/models/feed.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import '../widgets/EventViewPage.dart';

class head_notificationtile1 extends StatefulWidget {
  final Feeds feed;
  head_notificationtile1(this.feed);

  @override
  State<head_notificationtile1> createState() => _head_notificationtile1State();
}

class _head_notificationtile1State extends State<head_notificationtile1> {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(40.0),
        ),

        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        child: InkWell(
          onTap: (){
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
                          '${widget.feed.name}   (Denied)',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )
                      ),  //SizedBox(height: 10,),

                      //Text(
                         // '',
                         // style: TextStyle(
                            //fontSize: 20.0,
                           // color: Colors.black,
                            //fontWeight: FontWeight.bold,
                          //)
                      //),
                      SizedBox(height: 10,),
                      Text('Feedback: '+
                          widget.feed.feedback,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }
}