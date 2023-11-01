import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/models/clubclass.dart';
import 'package:flutter/material.dart';
import '../models/sportclass.dart';
import '../services/view_headstile1.dart';
import '../services/viewsporttile.dart';
import '../services/viewsporttile1.dart';
import 'event.dart';
import 'csheadclass.dart';
import 'package:eventbuzz/services/view_headstile.dart';
import 'package:eventbuzz/services/headlist.dart';
import 'package:eventbuzz/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
String name = "";
int count = 0;
class sports_heads extends StatefulWidget {


  sports_heads();
  @override
  State<sports_heads> createState() => _sports_headsState();
}

class _sports_headsState extends State<sports_heads> {

  List<heads> _filteredEvents = [];
  List<heads> events=[
    heads('Robo','Vhawdd','1as0'),
    heads('Roboad','Vhaffd','1as0'),

  ];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _filteredEvents = events;
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Sports>>.value(
      value : DatabaseService().sports,
      initialData: [],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Sport Heads Details',
          ),
          backgroundColor: Colors.pink.shade800,
        ),

        body:SingleChildScrollView(
          child: Column(
            children: [

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('events')
                    .snapshots(),
                builder: (context, snapshots) {
                  final sports = Provider.of<List<Sports>>(context);
                  return (snapshots.connectionState ==
                      ConnectionState.waiting) ?
                  Center(
                    child: CircularProgressIndicator(),
                  ) : SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child:ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: sports.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index)
                      {
                          return HeadTile1(sports[index]);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        )
      ),
    );
  }


}
