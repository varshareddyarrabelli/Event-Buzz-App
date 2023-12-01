import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/services/requesttile2.dart';
import 'package:eventbuzz/services/requesttile3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/eventclass.dart';
import '../services/database.dart';
import '../services/past_event_list.dart';
import '../services/requeststile1.dart';
import 'event.dart';
String name = "";
int count = 0;
class Request extends StatefulWidget {

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {

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

    return StreamProvider<List<Events>>.value(
      value : DatabaseService().events,
      initialData: [],
      child: Scaffold(
        appBar: AppBar(
          title: Text('REQUESTS'),
          backgroundColor: Colors.pink.shade800,
        ),
        body:
        // EventList(),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
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
                stream: FirebaseFirestore.instance.collection('events')
                    .snapshots(),
                builder: (context, snapshots) {
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
                      itemBuilder: (BuildContext context, int index)
                      {

                        final String stm, etm;
                        stm = events[index].date + ' ' + events[index].starttime;
                        etm = events[index].date + ' ' + events[index].endtime;

                        DateTime sdt = DateTime.parse(stm);
                        DateTime edt = DateTime.parse(etm);
                        if (events[index].flag1==0 &&(events[index].name.toString().toLowerCase().startsWith(name.toLowerCase()) ||
                            events[index].venue.toString().toLowerCase().startsWith(name.toLowerCase()) )) {
                          count = 1;
                          print(index);
                          if(events[index].flag2==0) {
                            return Requests1(events[index], 'Create');
                          }
                          if(events[index].flag2==1) {
                            return Requests2(events[index], 'Edit');
                          }
                          else{
                            return Requests3(events[index], 'Delete');
                          }
                        }
                        else if(count == 0 && index == events.length-1)
                        {
                          return Center(
                            child: Text('No Requests Found'),
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
