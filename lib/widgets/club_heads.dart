import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/models/clubclass.dart';
import 'package:flutter/material.dart';
import '../models/sportclass.dart';
import '../services/view_headstile1.dart';
import 'event.dart';
import 'csheadclass.dart';
import 'package:eventbuzz/services/view_headstile.dart';
import 'package:eventbuzz/services/headlist.dart';
import 'package:eventbuzz/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
String name = "";
int count = 0;
class club_heads extends StatefulWidget {


  club_heads();
  @override
  State<club_heads> createState() => _club_headsState();
}

class _club_headsState extends State<club_heads> {

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

    return StreamProvider<List<Clubs>>.value(
      value : DatabaseService().clubs,
      initialData: [],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Club Heads Details',
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
                  final clubs = Provider.of<List<Clubs>>(context);
                  return (snapshots.connectionState ==
                      ConnectionState.waiting) ?
                  Center(
                    child: CircularProgressIndicator(),
                  ) : SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child:ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: clubs.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index)
                      {
                        if ((clubs[index].name.toString().toLowerCase().startsWith(name.toLowerCase()))) {
                          return HeadTile(clubs[index]);
                          // index++;
                        }
                        else if(count == 0 && index == events.length-1)
                        {
                          return Center(
                            child: Text('No Events Found'),
                          );
                        }
                        else
                        {
                          return Card();
                        }

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