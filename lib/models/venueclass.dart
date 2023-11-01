import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Venues {

  final String name;
  String id;
  Venues({ required this.name,required this.id});

  Map<String, dynamic> tojson() => {
    'name': name,
    'id' : id,
  };
}