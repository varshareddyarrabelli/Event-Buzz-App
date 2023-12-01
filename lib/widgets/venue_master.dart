import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/models/clubclass.dart';
import 'package:eventbuzz/services/venuetile.dart';
import 'package:eventbuzz/services/viewclubtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/eventclass.dart';
import '../models/venueclass.dart';
import '../services/database.dart';
import '../services/past_event_list.dart';
import '../services/past_eventtitle.dart';
import '../services/viewclubtile1.dart';
import 'event.dart';
String name = "";
int count = 0;
class vvenues extends StatefulWidget {


  @override
  State<vvenues> createState() => _vvenuesState();
}

class _vvenuesState extends State<vvenues> {

  List<event> _filteredEvents = [];
  List<event> events=[
    event('Robo','Vhawdd','1as0','asa11','asadh'),
    event('Roboad','Vhaffd','1as0','asa11','asadh'),
    event('Roboads','Vhawdwd','1as0','asa11','asadh'),
    event('Roboadsd','Vhawd','1as0','asa11','asadh'),
    event('Robocd','Vhadfww','1as0','asa11','asadh'),
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

    return StreamProvider<List<Venues>>.value(
      value : DatabaseService().venues,
      initialData: [],
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add_venue');
          },
          child: Icon(Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.pink.shade800,
        ),

        appBar: AppBar(
          backgroundColor: Colors.pink.shade800,
          title: Text('Venues'),
        ),
        body:
        // EventList(),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5,),

              SizedBox(height: 5,),
              Card(
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search for venue'),
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('venues')
                    .snapshots(),
                builder: (context, snapshots) {
                  final venues = Provider.of<List<Venues>>(context);
                  return (snapshots.connectionState ==
                      ConnectionState.waiting) ?
                  Center(
                    child: CircularProgressIndicator(),
                  ) : SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: venues.length,
                      itemBuilder: (BuildContext context, int index)
                      {
                        if (venues[index].name.toString().toLowerCase().startsWith(name.toLowerCase()))
                        {
                        return VenueTile(venues[index]);
                        }
                        return SizedBox(height:0,width:0);

                      },
                    ),
                  );
                },
              ),
            ],

          ),
        ),),



    );
  }

  void _filterEvents(String query) {
    setState(() {
      _filteredEvents = events.where((event) =>
      event.name!.toLowerCase().contains(query.toLowerCase()) ||
          event.venue!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
