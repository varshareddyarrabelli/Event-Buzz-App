import 'package:eventbuzz/services/exportcsv.dart';
import 'package:eventbuzz/widgets/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/material/bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eventbuzz/auth.dart';
import 'dart:convert';
import 'package:eventbuzz/models/eventclass.dart';
import 'dart:io';
import 'package:eventbuzz/models/eventclass.dart';
import 'package:provider/provider.dart';
import 'package:eventbuzz/models/eventclass.dart';
import '../services/database.dart';

CollectionReference _collectionRef =
FirebaseFirestore.instance.collection('events');
int flag =0;
Future<List<Object?>> getData() async {
  // List<Events> event3 = event2.map((e)=>Events()).toList();
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('events').get();
  final CollectionReference eventcollection = FirebaseFirestore.instance.collection('events');
  List<Object?> list = querySnapshot.docs.map((e) => e.data()).toList();
  // List<Events> list = querySnapshot.docs.map((e) => Events(date: e["date"], venue: e., flag2: flag2, endtime: endtime, description: description, flag1: flag1, starttime: starttime, url: url, list1: list1, clubname: clubname, id2: id2, name: name, id: id, email: email))
  // List<Events> list = querySnapshot.docs.map((doc) => Events(date: doc['date'], venue: doc['venue'], flag2: doc['flag2'], endtime: doc['endtime'], description: doc['description'], flag1: doc['flag1'], starttime: doc['starttime'], url: doc['url'], list1: doc['list1'], clubname: doc['clubname'], id2: doc['id2'], name: doc['name'], id: doc['id'], email: doc['email'])).toList();
  print(eventcollection);
  return list;
}

Future downloadCollectionAsCSV(List<Events>? docs) async {
  docs = docs ?? [];


  String fileContent = "clubname, description, email, name, url, venue";
  docs.asMap().forEach((index, record) => fileContent = fileContent +
      "\n" +
      record.clubname.toString() +
      "," +
      record.description.toString() +
      "," +
      record.email.toString() +
      "," +
      record.name.toString() +
      "," +
      record.url.toString() +
      "," +
      record.venue.toString());
  final fileName = "FF" + DateTime.now().toString() + ".csv";

  // Encode the string as a List<int> of UTF-8 bytes
  var bytes = utf8.encode(fileContent);

  final stream = Stream.fromIterable(bytes);
  // download(stream, fileName);
}
class Admin_home extends StatefulWidget {
  const Admin_home({Key? key}) : super(key: key);

  @override
  _Admin_homeState createState() => _Admin_homeState();
}

class _Admin_homeState extends State<Admin_home> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
    Navigator.popUntil(context, ModalRoute.withName("/"));

  }
  Widget _signOutButton()
  {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }
  int _selectedIndex = 0;
  String selectedType = '';
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  onWillPop(context) async {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return false;
  }
  final RestorableInt _counter = RestorableInt(0);
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Events>>.value(
      value: DatabaseService().events,
      initialData: [],
      child: WillPopScope(
        onWillPop: () => onWillPop(context),
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Admin Home Page'),
              centerTitle: true,
              backgroundColor: Colors.pink.shade800,
              actions: [
                IconButton(
                  onPressed: signOut,
                  icon:const Icon(Icons.logout),)]
          ),

          body:Center(
            child: Column(
              //child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children : <Widget> [
                  Card(
                    margin: const EdgeInsets.fromLTRB(30,20,20,0),
                    color: Colors.pink.shade600,
                    child: SizedBox(
                      width: 300,
                      height: 50,

                      child : new InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/addclub');
                        },
                        child: Center(
                            child: ListTile(
                                textColor: Colors.white,
                                title: new Center(
                                  child: Text('Add Club/Sport'),
                                )
                            )
                        ),
                      ),

                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.fromLTRB(30,20,20,0),
                    color: Colors.pink.shade600,
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child : new InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/view_CS');
                          },
                          child: ListTile(
                              textColor: Colors.white,
                              title: new Center(
                                child : Text('View Club/Sports'),)
                          )
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.fromLTRB(30, 20, 20, 0),
                    color: Colors.pink.shade600,
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child : InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/requests');
                          },
                          child: ListTile(
                              textColor: Colors.white,
                              title: new Center(
                                child: Text('Requests'),)
                          )
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.fromLTRB(30,20,20,0),
                    color: Colors.pink.shade600,
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child : InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/csheads');
                          },
                          child: ListTile(
                              textColor: Colors.white,
                              title: new Center(
                                child: Text('View Clubheads/Sportheads'),)
                          )
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.fromLTRB(30,20,20,0),
                    color: Colors.pink.shade600,
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child : InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/venue_master');
                          },
                          child: ListTile(
                              textColor: Colors.white,
                              title: new Center(
                                child: Text('Venue Master'),)
                          )
                      ),
                    ),
                  ),

                  Column(
                    children: [
                      Card(
                        margin: const EdgeInsets.fromLTRB(30,20,20,0),
                        color: Colors.pink.shade600,
                        child: SizedBox(
                          width: 300,
                          height: 50,

                          child : InkWell(
                            onTap: ()  {
                              setState(() {
                                flag=1;
                              });
                              // final CollectionReference eventcollection = FirebaseFirestore.instance.collection('events');

                              // List<Events> list = event2.map((doc) => Events(date: doc['date'], venue: doc['venue'], flag2: doc['flag2'], endtime: doc['endtime'], description: doc['description'], flag1: doc['flag1'], starttime: doc['starttime'], url: doc['url'], list1: doc['list1'], clubname: doc['clubname'], id2: doc['id2'], name: doc['name'], id: doc['id'], email: doc['email'])).toList();
                              // downloadCollectionAsCSV(event3);
                              // print(event1);
                              // final events = Provider.of<List<Events>>(context);
                              // String s = FirebaseFirestore.instance.collection('events');
                              // StreamBuilder<QuerySnapshot>(
                              //   stream: FirebaseFirestore.instance.collection('events')
                              //       .snapshots(),
                              //   builder: (context, snapshots) {
                              //     List<Events> event1 = events;
                              //       print(event1);
                              //     return Card();
                              //   },
                              // );
                            },
                            child: ListTile(
                                textColor: Colors.white,
                                title: new Center(
                                  child: Text('Export to CSV'),)
                            ),
                          ),
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('events')
                              .snapshots(),
                          builder: (context, snapshots) {
                            int count=0;
                            final events = Provider.of<List<Events>>(context);
                            if(flag==1) {
                              flag=0;
                              SchedulerBinding.instance.addPostFrameCallback((_) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ExportCsv(events)),
                                );
                              });
                            }

                            return SizedBox(height: 0,width: 0,);
                          }),

                    ],
                  )

                ]
            ),
          ),

          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.pink.shade800,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
            ],
            selectedItemColor: Colors.black,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
