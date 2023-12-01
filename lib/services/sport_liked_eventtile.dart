import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/models/eventclass.dart';
import 'package:eventbuzz/widgets/EventViewPage.dart';
import 'package:eventbuzz/widgets/sporthome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import '../models/clubclass.dart';
import '../models/sportclass.dart';
import '../widgets/EventViewPage1.dart';

class sport_liked_eventtile extends StatefulWidget {

  final Sports sport;
  sport_liked_eventtile({ required this.sport });

  @override
  State<sport_liked_eventtile> createState() => _sport_liked_eventtileState();
}

class _sport_liked_eventtileState extends State<sport_liked_eventtile> {
  @override
  Widget build(BuildContext context) {
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
                  builder: (context) => SportHome(
                      widget.sport
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
                              widget.sport.name,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          SizedBox(width: 10,),
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
                            backgroundImage: NetworkImage(widget.sport.url),
                            radius: 40.0,
                          ),


                        ],
                      ),
                    ) ,
                  ],
                ),
                IconButton(
                  onPressed: (){
                    int index=0;
                    dynamic temp = json.decode(widget.sport.list1);
                    var seen = Set<String>();
                    dynamic uniquelist = temp.where((country) => seen.add(country)).toList();
                    uniquelist.remove(FirebaseAuth.instance.currentUser!.uid);
                    String temp2 = json.encode(uniquelist);
                    final docuser = FirebaseFirestore.instance.collection('sports').doc(widget.sport.id);
                    docuser.update(
                        {
                          'list1':temp2,
                        }
                    );
                  },
                  icon: Icon(Icons.remove_circle,
                    color: Colors.red,
                    size: 40,),),
              ],
            ),
          ),
        )
    );
  }
}