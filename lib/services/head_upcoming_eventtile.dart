import 'package:eventbuzz/models/eventclass.dart';
import 'package:eventbuzz/widgets/editevent.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import '../widgets/EventViewPage.dart';

class Head_Upcoming_EventTile extends StatefulWidget {

  final Events event;
  Head_Upcoming_EventTile({ required this.event });

  @override
  State<Head_Upcoming_EventTile> createState() => _Head_Upcoming_EventTileState();
}

class _Head_Upcoming_EventTileState extends State<Head_Upcoming_EventTile> {
  @override
  Widget build(BuildContext context) {
    Uri url = Uri.parse(widget.event.url);
    return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(20.0),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
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
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          SizedBox(width: 10,),
                          Text(
                              widget.event.venue,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )
                          ),
                          SizedBox(width: 10,),
                          Text(
                              widget.event.starttime,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )
                          ),
                          SizedBox(width: 10,),
                          Text(
                              widget.event.endtime,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )
                          ),
                          SizedBox(width: 10,),
                          Text(
                              widget.event.date,
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
                          // Image.network(event.url),
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.event.url),
                            radius: 40.0,
                          ),
                        ],
                      ),
                    ) ,
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
                  child: Container(
                    child: IconButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => editevent(
                                    widget.event,widget.event.clubname
                                )),
                          );
                        },
                        icon:   Icon(Icons.mode_edit_outline)),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}