import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Feeds {

  final String feedback;
  final String name;
  final String mail;
  int flag;
  String dtt;
  Feeds({ required this.feedback,required this.name, required this.mail,required this.flag,required this.dtt });

  Map<String, dynamic> toJson() => {
    'feedback': feedback,
    'name': name,
    'dtt':dtt,
    'mail': mail,
    'flag':flag,
  };
}