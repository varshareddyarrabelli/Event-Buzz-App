
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../models/eventclass.dart';
import '../models/venueclass.dart';
import '../services/database.dart';

import 'Clubhead_home.dart';

Future create(Events event1) async {
  final docuser = FirebaseFirestore.instance.collection('events').doc();
  event1.id = docuser.id;
  event1.dtt = event1.date +" "+event1.starttime;
  event1.email = FirebaseAuth.instance.currentUser!.email!;
  final json = event1.toJson();
  await docuser.set(json);

}
String selectedType = '';

class editevent extends StatefulWidget {
  final Events event;
  final String name;
  editevent(this.event,this.name);
  @override
  _editeventState createState() => _editeventState();
}
class _editeventState extends State<editevent> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final controllername = TextEditingController(text: widget.event.name);
    final controllerurl = TextEditingController(text: widget.event.url);
    final controllerdate = TextEditingController(text: widget.event.date);
    final controllerstarttime = TextEditingController(text: widget.event.starttime);
    final controllerendtime = TextEditingController(text: widget.event.endtime);
     final controllervenue = TextEditingController(text: widget.event.venue);
    final controllerdescription = TextEditingController(text: widget.event.description);

    return StreamProvider<List<Venues>>.value(
        value: DatabaseService().venues,
    initialData: [],
    child:Scaffold(
      appBar: AppBar(
        title: Text('Edit Event Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('venues')
                    .snapshots(),
                builder: (context, snapshots) {
                  final venues = Provider.of<List<Venues>>(context);
                  List<String>venue1=[];
                  for(int k=0;k<venues.length;k++)
                  {
                    venue1.insert(0, venues[k].name);
                  }
                  return DropdownButtonFormField<String>(
                    value: selectedType.isNotEmpty ? selectedType : null,
                    onChanged: (value) {
                      selectedType = value!;
                      setState(() {
                        selectedType = value;
                      });
                    },
                    items: venue1
                        .map((accountType) => DropdownMenuItem(
                      value: accountType,
                      child: Text(accountType),
                    ))
                        .toList(),
                    decoration: InputDecoration(
                      labelText: 'Choose a venue first',
                      border: OutlineInputBorder(),
                      hintText: widget.event.venue,
                    ),
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Event Name',
                ),
                controller: controllername,
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Event Description',
                ),
                controller: controllerdescription,
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Date, format like YYYY-MM-DD',
                ),

                controller: controllerdate,
              ),
              SizedBox(height: 16.0),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Start time, format like 19:00',
                ),
                controller: controllerstarttime,
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'End Time, format like 20:00',
                ),
                controller: controllerendtime,
              ),
              SizedBox(height: 16.0),
              // StreamBuilder<QuerySnapshot>(
              //   stream: FirebaseFirestore.instance.collection('venues')
              //       .snapshots(),
              //   builder: (context, snapshots) {
              //     final venues = Provider.of<List<Venues>>(context);
              //     List<String>venue1=[];
              //     for(int k=0;k<venues.length;k++)
              //     {
              //       venue1.insert(0, venues[k].name);
              //     }
              //     return DropdownButtonFormField<String>(
              //       value: widget.event.venue,
              //       onChanged: (value) {
              //         selectedType = value!;
              //         setState(() {
              //           selectedType = value;
              //         });
              //       },
              //       items: venue1
              //           .map((accountType) => DropdownMenuItem(
              //         value: accountType,
              //         child: Text(accountType),
              //       ))
              //           .toList(),
              //       decoration: InputDecoration(
              //         border: OutlineInputBorder(),
              //         hintText: widget.event.venue,
              //       ),
              //     );
              //   },
              // ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Image URL',
                ),
                controller: controllerurl,
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                child: Text('Edit Event'),
                onPressed: () {
                  final event1 = Events(
                    clubname : widget.name,
                    name : controllername.text,
                    url : controllerurl.text,
                    venue : selectedType,
                    endtime : controllerendtime.text,
                    email : '',
                    starttime : controllerstarttime.text,
                    date : controllerdate.text,
                    description: controllerdescription.text,
                    id: '',
                    id2:widget.event.id,
                    flag1:0,
                    flag2:1,
                    list1: '[""]',
                    dtt: '',
                  );
                  if(controllerdate.text.isNotEmpty && selectedType.isNotEmpty && controllername.text.isNotEmpty && controllerurl.text.isNotEmpty
                      && controllerendtime.text.isNotEmpty && controllerstarttime.text.isNotEmpty && controllerdescription.text.isNotEmpty) {
                    create(event1);
                    final docuser = FirebaseFirestore.instance.collection('events').doc(widget.event.id);
                    docuser.update(
                        {
                          'flag1' : -1,
                          'flag2' : 1,
                        }
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Clubhead_home(
                            FirebaseAuth.instance.currentUser?.email,
                              widget.name
                          )),
                    );
                  }
                },
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                child: Text('Delete Event'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  final docuser = FirebaseFirestore.instance.collection('events').doc(widget.event.id);
                  docuser.update(
                      {
                        'flag1' : 0,
                        'flag2' : -1,
                      }
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Clubhead_home(
                            FirebaseAuth.instance.currentUser?.email,
                            widget.name
                        )),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
