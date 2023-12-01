import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Clubs {

  final String name;
  final String clubhead;
  final String headmail;
  final String headphone;
  final String url;
  final String description;
  String id;
  String list1;
  Clubs({ required this.name,required this.id, required this.headmail,required this.headphone,required this.url,required this.description,required this.clubhead,required this.list1 });

  Map<String, dynamic> tojson() => {
    'name': name,
    'id': id,
    'headmail': headmail,
    'headphone': headphone,
    'url': url,
    'description': description,
    'clubhead': clubhead,
    'list1':list1,
  };
}