import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/models/clubclass.dart';
import 'package:eventbuzz/services/viewclubtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/eventclass.dart';
import '../services/database.dart';
import '../services/past_event_list.dart';
import '../services/past_eventtitle.dart';
import '../services/viewclubtile1.dart';
import 'event.dart';
String name = "";
int count = 0;
class view_clubs extends StatefulWidget {


  @override
  State<view_clubs> createState() => _view_clubsState();
}

class _view_clubsState extends State<view_clubs> {

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

    return StreamProvider<List<Clubs>>.value(
      value : DatabaseService().clubs,
      initialData: [],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('View Clubs'),
          backgroundColor: Colors.pink.shade800,
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
                      hintText: 'Search for title...'),
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('clubs')
                    .snapshots(),
                builder: (context, snapshots) {
                  final clubs = Provider.of<List<Clubs>>(context);
                  return (snapshots.connectionState ==
                      ConnectionState.waiting) ?
                  Center(
                    child: CircularProgressIndicator(),
                  ) : SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: clubs.length,
                      itemBuilder: (BuildContext context, int index)
                      {
                        if(clubs[index].name.toString().toLowerCase().startsWith(name.toLowerCase())) {
                          return ClubTile(clubs[index]);
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

Widget eventtemplate (event, BuildContext context)
{
  return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.pink.shade400,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),

      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: Column(
          children: <Widget>[
            new InkWell(
              onTap: (){
                Navigator.pushNamed(context, '/viewevent');
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(width: 10,),
                          Text(
                              event.name,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          SizedBox(width: 10,),
                          Text(
                              event.venue,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )
                          ),
                          SizedBox(width: 10,),
                          Text(
                              event.timings,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )
                          ),
                          SizedBox(width: 10,),
                          Text(
                              event.date,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/slider2.jpeg'),
                            radius: 40.0,
                          ),
                        ],
                      ),
                    ) ,

                  ],
                ),

              ),

            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0,0.0,20.0,0.0),
              child: Row(
                children: <Widget>[
                  Text('Give Rating:'),
                  SizedBox(width: 80.0,),

                  Icon(
                    Icons.star,
                  ),
                  Icon(
                    Icons.star,
                  ),
                  Icon(
                    Icons.star,
                  ),
                  Icon(
                    Icons.star,
                  ),
                  Icon(
                    Icons.star,
                  )
                ],
              ),
            ),
          ]
      )
  );
}