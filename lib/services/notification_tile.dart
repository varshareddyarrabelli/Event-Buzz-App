import 'package:eventbuzz/models/eventclass.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import '../widgets/EventViewPage.dart';

class Notification_Tile extends StatefulWidget {
  final int diff;
  final Events event;
  Notification_Tile(this.event, this.diff );

  @override
  State<Notification_Tile> createState() => _Notification_TileState();
}

class _Notification_TileState extends State<Notification_Tile> {
  @override
  Widget build(BuildContext context) {
    Uri url = Uri.parse(widget.event.url);
    return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xff764abc),
          ),
          borderRadius: BorderRadius.circular(40.0),
        ),

        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        child: InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => viewevent(
                      widget.event
                  )),
            );
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
                          widget.event.name,
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      SizedBox(height: 10,),
                      Text(
                          'Event is about to begin in ${widget.diff} minutes',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      SizedBox(height: 20,),
                      Text('Tap for more details.....'),

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