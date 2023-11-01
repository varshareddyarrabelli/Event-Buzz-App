import 'package:eventbuzz/models/clubclass.dart';
import 'package:eventbuzz/services/viewclubtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClubList extends StatefulWidget {
  @override
  _ClubListState createState() => _ClubListState();
}

class _ClubListState extends State<ClubList> {
  @override
  Widget build(BuildContext context) {

    final clubs = Provider.of<List<Clubs>>(context);
    return ListView.builder(
      itemCount: clubs.length,
      itemBuilder: (context, index) {
        return ClubTile1( clubs[index]);
      },
    );
  }
}