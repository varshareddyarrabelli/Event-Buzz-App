import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/widgets/event.dart';
import 'package:flutter/material.dart';

class Events {

  final String name;
  final String starttime;
  final String endtime;
  final String venue;
  final String url;
  String dtt;
  String email;
  final String description;
  final String clubname;
  final String date;
  String id2;
  String id;
  int flag1;
  int flag2;
  String list1;

  Events(
      { required this.date, required this.venue, required this.flag2, required this.endtime, required this.description, required this.flag1, required this.starttime,required this.dtt,
        required this.url, required this.list1, required this.clubname, required this.id2, required this.name, required this.id, required this.email});

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'id': id,
        'email': email,
        'venue': venue,
        'url': url,
        'description': description,
        'clubname': clubname,
        'date': date,
        'endtime': endtime,
        'starttime': starttime,
        'flag1': flag1,
        'flag2': flag2,
        'id2': id2,
        'list1':list1,
        'dtt':dtt,
      };

  // static dynamic getListMap(List<dynamic> items) {
  //   if (items == null) {
  //     return null;
  //   }
  //   List<Map<String, dynamic>> list = [];
  //   items.forEach((element) {
  //     list.add(element.toMap());
  //   });
  //   return list;
  // }
}