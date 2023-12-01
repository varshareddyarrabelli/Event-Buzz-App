import 'package:eventbuzz/models/clubclass.dart';
import 'package:eventbuzz/widgets/venue_master.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/models/sportclass.dart';

import '../models/venueclass.dart';

class Add_venue extends StatefulWidget {
  @override
  _Add_venueState createState() => _Add_venueState();
}
Future create(Venues venue1) async {
  final docuser = FirebaseFirestore.instance.collection('venues').doc();
  venue1.id = docuser.id;
  final json = venue1.tojson();
  await docuser.set(json);

}
// Future<List<Venues>> getProductCategory(String category) async {
//   QuerySnapshot query = await _firestore.collection(collection)
//       .where("category", isEqualTo: category)
//       .get();
//
//   if(query.docs.isNotEmpty){
//     query.docs.forEach((element) {
//       productCategory.add(ProductModel.fromSnapshot(element.data()));
//     });
//   }
//   return productCategory;
// }


class _Add_venueState extends State<Add_venue> {
  final _firestore = FirebaseFirestore.instance;
  final controllername = TextEditingController();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Venue'),
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
                  labelText: 'Enter Venue',
                  prefixIcon: Icon(Icons.place,color: Colors.pink.shade800,),
                ),
                controller: controllername,
              ),
              SizedBox(height: 16.0),


              SizedBox(height: 32.0),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () async {
                  // TODO: Save event details to database or do something else
                  // with the event details

                  final venue1 = Venues(
                    name : controllername.text,
                    id: '',
                  );
                  create(venue1);
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
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