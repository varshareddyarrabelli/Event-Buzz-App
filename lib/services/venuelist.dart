// import 'package:eventbuzz/models/clubclass.dart';
// import 'package:eventbuzz/services/venuetile.dart';
// import 'package:eventbuzz/models/venueclass.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class VenueList extends StatefulWidget {
//   @override
//   _VenueListState createState() => _VenueListState();
// }
//
// class _VenueListState extends State<VenueList> {
//   @override
//   Widget build(BuildContext context) {
//
//     final venues = Provider.of<List<Venues>>(context);
//     return ListView.builder(
//       itemCount: venues.length,
//       itemBuilder: (context, index) {
//         return VenueTile(venue: venues[index]);
//       },
//     );
//   }
// }