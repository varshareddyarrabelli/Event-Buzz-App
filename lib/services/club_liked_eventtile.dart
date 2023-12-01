import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/models/eventclass.dart';
import 'package:eventbuzz/widgets/Clubhome.dart';
import 'package:eventbuzz/widgets/EventViewPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import '../models/clubclass.dart';
import '../widgets/EventViewPage1.dart';

class club_liked_eventtile extends StatefulWidget {

  final Clubs club;
  club_liked_eventtile({ required this.club });

  @override
  State<club_liked_eventtile> createState() => _club_liked_eventtileState();
}

class _club_liked_eventtileState extends State<club_liked_eventtile> {
  @override
  Widget build(BuildContext context) {
    Uri url = Uri.parse(widget.club.url);
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
                  builder: (context) => Clubhome(
                      widget.club
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
                              widget.club.name,
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
                            backgroundImage: NetworkImage(widget.club.url),
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
                    dynamic temp = json.decode(widget.club.list1);
                    var seen = Set<String>();
                    dynamic uniquelist = temp.where((country) => seen.add(country)).toList();
                    uniquelist.remove(FirebaseAuth.instance.currentUser!.uid);
                    String temp2 = json.encode(uniquelist);
                    final docuser = FirebaseFirestore.instance.collection('clubs').doc(widget.club.id);
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