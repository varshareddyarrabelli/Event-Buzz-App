import 'package:eventbuzz/models/clubclass.dart';
import 'package:eventbuzz/services/view_headstile.dart';
import 'package:eventbuzz/services/viewclubtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeadList extends StatefulWidget {
  @override
  _HeadListState createState() => _HeadListState();
}

class _HeadListState extends State<HeadList> {
  @override
  Widget build(BuildContext context) {

    final clubs = Provider.of<List<Clubs>>(context);
    return ListView.builder(
      itemCount: clubs.length,
      itemBuilder: (context, index) {
        return HeadTile(clubs[index]);
      },
    );
  }
}