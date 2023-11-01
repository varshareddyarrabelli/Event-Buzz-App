import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/models/eventclass.dart';
import 'package:eventbuzz/widgets/EventViewPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import '../widgets/EventViewPage1.dart';

class Upcoming_EventTile extends StatefulWidget {

  final Events event;
  Upcoming_EventTile({ required this.event });

  @override
  State<Upcoming_EventTile> createState() => _Upcoming_EventTileState();
}

class _Upcoming_EventTileState extends State<Upcoming_EventTile> {
  @override
  Widget build(BuildContext context) {
    Uri url = Uri.parse(widget.event.url);
    return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xff764abc),
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
                              '${widget.event.starttime} - ${widget.event.endtime}',
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
                SizedBox(height: 10,),
                IconButton(
                  onPressed: (){

                    dynamic temp = json.decode(widget.event.list1);
                    temp.insert(0, FirebaseAuth.instance.currentUser!.uid);
                    String temp2 = json.encode(temp);
                    final docuser = FirebaseFirestore.instance.collection('events').doc(widget.event.id);
                    docuser.update(
                        {
                          'list1':temp2,
                        }
                    );
                  },
                  icon: Icon(Icons.thumb_up_sharp,
                    size: 30,),),
              ],
            ),
          ),
        )
    );
  }
}