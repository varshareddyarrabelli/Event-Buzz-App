import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/eventclass.dart';
import '../services/database.dart';
import '../services/head_past_eventlist.dart';
import '../services/head_past_eventtile.dart';
import 'createevent.dart';
import 'event.dart';
String name="";
class head_Past_Page extends StatefulWidget {

  final String message;
  final String? email;
  final String name;

  head_Past_Page(this.message,this.email,this.name);
  @override
  State<head_Past_Page> createState() => _head_Past_PageState();
}

class _head_Past_PageState extends State<head_Past_Page> {

  List<event> _filteredEvents = [];
  List<event> events=[
    event('Robo','Vhawdd','1as0','asa11','asadh'),
    event('Roboad','Vhaffd','1as0','asa11','asadh'),
    event('Roboads','Vhawdwd','1as0','asa11','asadh'),
    event('Roboadsd','Vhawd','1as0','asa11','asadh'),
    event('Robocd','Vhadfww','1as0','asa11','asadh'),
  ];
  TextEditingController _searchController = TextEditingController();
  _getDateTime() {
    setState(() {
      now = DateTime.now();
    });
  }
  @override
  void initState() {
    _getDateTime();
    super.initState();
    Timer.periodic(Duration(seconds: 60), (_) => _getDateTime());
  }

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Events>>.value(
        value : DatabaseService().events,
    initialData: [],
    child:Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => createevent(
                    widget.name
                )),

          );
        },
        child: Icon(Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5,),
            Text(widget.message,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            SizedBox(height: 5,),
            Card(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search by name or venue'),
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('events')
                  .snapshots(),
              builder: (context, snapshots) {int count=0;

              final events = Provider.of<List<Events>>(context);
              events.sort((a,b)=>DateTime.parse(a.dtt).compareTo(DateTime.parse(b.dtt)));
                return (snapshots.connectionState ==
                    ConnectionState.waiting) ?
                Center(
                  child: CircularProgressIndicator(),
                ) : SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: events.length,
                    reverse: true,
                    itemBuilder: (BuildContext context, int index)
                    {

                      final String stm, etm;
                      stm = events[index].date + ' ' + events[index].starttime;
                      etm = events[index].date + ' ' + events[index].endtime;

                      DateTime sdt = DateTime.parse(stm);
                      DateTime edt = DateTime.parse(etm);
                      if (events[index].flag1==1 && events[index].clubname == widget.name && edt.compareTo(now) < 0 && (events[index].name.toString().toLowerCase().startsWith(name.toLowerCase()) ||
                          events[index].venue.toString().toLowerCase().startsWith(name.toLowerCase()) )) {
                        count = 1;
                        return Head_Past_EventTile(event: events[index]);
                      }
                      else if(count == 0 && index == events.length-1)
                      {
                        return Center(
                          child: Text('No Events Found'),
                        );
                      }
                      else
                      {
                        return SizedBox(height: 0, width: 0,);
                      }

                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),

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
          color: Colors.blue,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Average Rating:'),
                Row(
                  children: [
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
                )

                ],
              ),
            ),
          ]
      )
  );
}