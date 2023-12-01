import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Feedbacks {

  final String feedback;
  final String event_id;
  final double rating;
  Feedbacks({ required this.feedback,required this.event_id, required this.rating });

  Map<String, dynamic> toJson() => {
    'feedback': feedback,
    'event_id': event_id,
    'rating': rating,
  };
}