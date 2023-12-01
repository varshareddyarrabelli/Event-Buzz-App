// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:eventbuzz/models/eventclass.dart';
// import 'package:eventbuzz/widgets/EventViewPage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'dart:core';
//
// import '../models/venueclass.dart';
// import '../widgets/EventViewPage1.dart';
//
// class new_new extends StatefulWidget {
//
//
//
//   @override
//   State<new_new> createState() => _new_newState();
// }
//
// class _new_newState extends State<new_new> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('venues')
//           .snapshots(),
//       builder: (context, snapshots) {
//         final venues = Provider.of<List<Venues>>(context);
//         List<String>venue1=[];
//         for(int k=0;k<venues.length;k++)
//         {
//           venue1.insert(0, venues[k].name);
//         }
//         // return DropdownButtonFormField<String>(
//         //   value: widget.event.venue,
//         //   onChanged: (value) {
//         //     selectedType = value!;
//         //     setState(() {
//         //       selectedType = value;
//         //     });
//         //   },
//         //   items: venue1
//         //       .map((accountType) => DropdownMenuItem(
//         //     value: accountType,
//         //     child: Text(accountType),
//         //   ))
//         //       .toList(),
//         //   decoration: InputDecoration(
//         //     border: OutlineInputBorder(),
//         //     hintText: widget.event.venue,
//         //   ),
//         // );
//       }
//     );
//   }
// }