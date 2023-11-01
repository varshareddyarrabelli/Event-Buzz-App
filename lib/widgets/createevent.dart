import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/models/eventclass.dart';
import 'package:provider/provider.dart';
import '../models/venueclass.dart';
import '../services/database.dart';
import 'Clubhead_home.dart';
import 'package:eventbuzz/models/eventclass.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class createevent extends StatefulWidget {
  final String name;
  createevent(this.name);
  @override
  _createeventState createState() => _createeventState();
}
Future create(Events event1) async {
  final docuser = FirebaseFirestore.instance.collection('events').doc();
  event1.id = docuser.id;
  event1.dtt = event1.date + " " + event1.starttime;
  event1.email = FirebaseAuth.instance.currentUser!.email!;
  final json = event1.toJson();
// final json1 = event1.tojjson();
  await docuser.set(json);
}
class _createeventState extends State<createevent> {
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print(selectedDate);
      });
    }
  }
  final _firestore = FirebaseFirestore.instance;
  final controllername = TextEditingController();
  final controllerurl = TextEditingController();
  final controllerdate = TextEditingController();
  final controllerstarttime = TextEditingController();
  final controllerendtime = TextEditingController();
  final controllervenue = TextEditingController();
  final controllerdescription = TextEditingController();
  String selectedType = '';
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Venues>>.value(
        value: DatabaseService().venues,
    initialData: [],
    child: Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
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

              // SfCalendar(
              //   view: CalendarView.month,
              // ),

              // Text("${selectedDate.toLocal()}".split(' ')[0]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text('${selectedDate.toString().substring(0,10)}'),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                    ),
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
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
                  labelText: 'End Time, format like 02:00',
                ),
                controller: controllerendtime,
              ),
              SizedBox(height: 16.0),
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
        setState(() {
          selectedType = value!;
        });
      },
      items: venue1
          .map((accountType) => DropdownMenuItem(
        value: accountType,
        child: Text(accountType),
      ))
          .toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Select venue',
      ),
    );
    },
    ),
              // TextField(
              //   decoration: InputDecoration(
              //     labelText: 'Event Venue',
              //   ),
              //   controller: controllervenue,
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
                child: Text('Create Event'),
                onPressed: () {
                  final event1 = Events(
                    clubname : widget.name,
                    name : controllername.text,
                    url : controllerurl.text,
                    venue : selectedType,
                    endtime : controllerendtime.text,
                    email : '',
                    starttime : controllerstarttime.text,
                    date : selectedDate.toString().substring(0,10),
                    description: controllerdescription.text,
                    id: '',
                    id2:'',
                    flag1:0,
                    flag2:0,
                    list1: '[""]',
                    dtt: '',
                  );
                  if(selectedType.isNotEmpty && controllername.text.isNotEmpty && controllerurl.text.isNotEmpty
                  && controllerendtime.text.isNotEmpty && controllerstarttime.text.isNotEmpty && controllerdescription.text.isNotEmpty) {
                      create(event1);
                      Navigator.of(context).pop();
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
