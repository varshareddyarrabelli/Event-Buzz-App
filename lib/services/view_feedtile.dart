import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/models/eventclass.dart';
import 'package:eventbuzz/widgets/EventViewPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import '../widgets/EventViewPage1.dart';

class View_Feedtile extends StatefulWidget {

  final String message;
  View_Feedtile(this.message );

  @override
  State<View_Feedtile> createState() => _View_FeedtileState();
}

class _View_FeedtileState extends State<View_Feedtile> {
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(widget.message),
        )
    );
  }
}