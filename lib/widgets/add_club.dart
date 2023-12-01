import 'package:eventbuzz/models/clubclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/models/sportclass.dart';

class Add_club extends StatefulWidget {
  @override
  _Add_clubState createState() => _Add_clubState();
}
Future create(Clubs club1) async {
  final docuser = FirebaseFirestore.instance.collection('clubs').doc();
  club1.id = docuser.id;
  final json = club1.tojson();
  await docuser.set(json);

}
Future create1(Sports sport1) async {
  final docuser = FirebaseFirestore.instance.collection('sports').doc();
  sport1.id = docuser.id;
  final json = sport1.toJson();
  await docuser.set(json);

}

class _Add_clubState extends State<Add_club> {
  final _firestore = FirebaseFirestore.instance;
  final controllername = TextEditingController();
  final controllerclubhead = TextEditingController();
  final controllerurl = TextEditingController();
  final controllerheadmail = TextEditingController();
  final controllerheadphone = TextEditingController();
  final controllerdescription = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Club/Sports'),
        backgroundColor: Colors.pink.shade800,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Club/Sport Name',
                  labelStyle: TextStyle(color: Colors.pink.shade400,fontStyle:FontStyle.normal,fontSize: 12),
                  prefixIcon: Icon(Icons.house_rounded,color: Colors.pink.shade800,),
                ),
                controller: controllername,
              ),
              SizedBox(height: 16.0),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Head Name',
                  labelStyle: TextStyle(color: Colors.pink.shade400,fontStyle:FontStyle.normal,fontSize: 12),
                  prefixIcon: Icon(Icons.person,color: Colors.pink.shade800,),
                ),
                controller: controllerclubhead,
              ),
              SizedBox(height: 16.0),


              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Head email',
                  labelStyle: TextStyle(color: Colors.pink.shade400,fontStyle:FontStyle.normal,fontSize: 12),
                  prefixIcon: Icon(Icons.email, color: Colors.pink.shade800,),
                ),
                controller: controllerheadmail,
              ),



              SizedBox(height: 16.0,),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Head mobile number',
                  labelStyle: TextStyle(color: Colors.pink.shade400,fontStyle:FontStyle.normal,fontSize: 12),
                  prefixIcon: Icon(Icons.mobile_friendly_rounded,color: Colors.pink.shade800,),
                ),
                controller: controllerheadphone,
              ),
              SizedBox(height: 16.0,),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Club/Sport Description',
                  labelStyle: TextStyle(color: Colors.pink.shade400,fontStyle:FontStyle.normal,fontSize: 12),
                  prefixIcon: Icon(Icons.description,color: Colors.pink.shade800,),
                ),
                controller: controllerdescription,
              ),
              SizedBox(height: 16.0,),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Image Url',
                  labelStyle: TextStyle(color: Colors.pink.shade400,fontStyle:FontStyle.normal,fontSize: 12),
                  prefixIcon: Icon(Icons.link,color: Colors.pink.shade800,),

                ),
                controller: controllerurl,
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                child: Text('CREATE CLUB'),
                onPressed: () {
                  // TODO: Save event details to database or do something else
                  // with the event details
                  final club1 = Clubs(
                    name : controllername.text,
                    url : controllerurl.text,
                    headmail : controllerheadmail.text,
                    headphone : controllerheadphone.text,
                    clubhead : controllerclubhead.text,
                    description: controllerdescription.text,
                    id: '',
                    list1: '[""]',
                  );
                  create(club1);
                  Navigator.pushNamed(context, '/admin_home');
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink.shade800),
                    padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18))),


              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                child: Text('CREATE SPORT'),
                onPressed: () {
                  // TODO: Save event details to database or do something else
                  // with the event details
                  final sport1 = Sports(
                    name : controllername.text,
                    url : controllerurl.text,
                    headmail : controllerheadmail.text,
                    headphone : controllerheadphone.text,
                    clubhead : controllerclubhead.text,
                    description: controllerdescription.text,
                    id: '',
                    list1: '[""]',
                  );
                  create1(sport1);
                  Navigator.pushNamed(context, '/admin_home');
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink.shade800),
                    padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18))),

              ),
            ],
          ),
        ),
      ),
    );
  }
}