import 'package:eventbuzz/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../models/clubclass.dart';
import '../models/eventclass.dart';
import '../models/sportclass.dart';
import 'Clubhead_home.dart';


class Edit_sport extends StatefulWidget {
  final Sports sport;
  Edit_sport(this.sport);
  @override
  _Edit_sportState createState() => _Edit_sportState();
}
int flag=0;

class _Edit_sportState extends State<Edit_sport> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final controllername = TextEditingController(text: widget.sport.name);
    final controllerclubhead = TextEditingController(text: widget.sport.clubhead);
    final controllerurl = TextEditingController(text: widget.sport.url);
    final controllerheadphone = TextEditingController(text: widget.sport.headphone);
    final controllerheadmail = TextEditingController(text: widget.sport.headmail);
    final controllerdescription = TextEditingController(text: widget.sport.description);

    return StreamProvider<List<Events>>.value(
      value : DatabaseService().events,
      initialData: [],
      child:Scaffold(
        appBar: AppBar(
          title: Text('Edit Sport'),
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
                    labelText: 'Club Description',
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
                  child: Text('Confirm'),
                  onPressed: () {
                    // TODO: Save event details to database or do something else
                    // with the event details
                    final docuser = FirebaseFirestore.instance.collection('sports').doc(widget.sport.id);

                    docuser.update(
                        {
                          'clubhead' : controllerclubhead.text,
                          'name' : controllername.text,
                          'url' : controllerurl.text,
                          'headphone' : controllerheadphone.text,
                          'headmail' : controllerheadmail.text,
                          'description': controllerdescription.text,
                        }
                    );
                    Navigator.of(context).pop();
                    //add redirecting page url
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18))),
                ),
                SizedBox(height: 32.0),

                ElevatedButton(
                  child: Text('Delete'),
                  onPressed: () {
                    // TODO: Save event details to database or do something else
                    // with the event details
                    final doc = FirebaseFirestore.instance.collection('sports').doc(widget.sport.id);
                    setState(() {
                      flag=1;
                    });
                    doc.delete();
                    Navigator.of(context).pop();
                  },


                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18))),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('events')
                        .snapshots(),
                    builder: (context, snapshots) {
                      int count=0;
                      final events = Provider.of<List<Events>>(context);
                      if(flag==1)
                      {
                        print (268);
                        for(int i=0;i<events.length;i++)
                        {
                          if (widget.sport.name == events[i].clubname)
                          {
                            final docs = FirebaseFirestore.instance.collection(
                                'events').doc(events[i].id);
                            docs.delete();
                          }
                        }
                        flag=0;

                      }

                      return Card();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../models/sportclass.dart';
// import 'Clubhead_home.dart';
//
//
// class Edit_sport extends StatefulWidget {
//   final Sports sport;
//   Edit_sport(this.sport);
//   @override
//   _Edit_sportState createState() => _Edit_sportState();
// }
//
// class _Edit_sportState extends State<Edit_sport> {
//   final _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     final controllername = TextEditingController(text: widget.sport.name);
//     final controllerclubhead = TextEditingController(text: widget.sport.clubhead);
//     final controllerurl = TextEditingController(text: widget.sport.url);
//     final controllerheadphone = TextEditingController(text: widget.sport.headphone);
//     final controllerheadmail = TextEditingController(text: widget.sport.headmail);
//     final controllerdescription = TextEditingController(text: widget.sport.description);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit sport'),
//         backgroundColor: Colors.pink.shade800,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Enter Sport Name',
//                   labelStyle: TextStyle(color: Colors.pink.shade400,fontStyle:FontStyle.normal,fontSize: 12),
//                   prefixIcon: Icon(Icons.house_rounded,color: Colors.pink.shade800,),
//                 ),
//                 controller: controllername,
//               ),
//               SizedBox(height: 16.0),
//
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Enter Head Name',
//                   labelStyle: TextStyle(color: Colors.pink.shade400,fontStyle:FontStyle.normal,fontSize: 12),
//                   prefixIcon: Icon(Icons.person,color: Colors.pink.shade800,),
//                 ),
//                 controller: controllerclubhead,
//               ),
//               SizedBox(height: 16.0),
//
//
//               TextField(
//                 decoration:  InputDecoration(
//                   labelText: 'Enter Head email',
//                   labelStyle: TextStyle(color: Colors.pink.shade400,fontStyle:FontStyle.normal,fontSize: 12),
//                   prefixIcon: Icon(Icons.email, color: Colors.pink.shade800,),
//                 ),
//                 controller: controllerheadmail,
//               ),
//
//
//
//               SizedBox(height: 16.0,),
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Enter Head mobile number',
//                   labelStyle: TextStyle(color: Colors.pink.shade400,fontStyle:FontStyle.normal,fontSize: 12),
//                   prefixIcon: Icon(Icons.mobile_friendly_rounded,color: Colors.pink.shade800,),
//                 ),
//                 controller: controllerheadphone,
//               ),
//               SizedBox(height: 16.0,),
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Sport Description',
//                   labelStyle: TextStyle(color: Colors.pink.shade400,fontStyle:FontStyle.normal,fontSize: 12),
//                   prefixIcon: Icon(Icons.description,color: Colors.pink.shade800,),
//                 ),
//                 controller: controllerdescription,
//               ),
//               SizedBox(height: 16.0,),
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Image Url',
//                   labelStyle: TextStyle(color: Colors.pink.shade400,fontStyle:FontStyle.normal,fontSize: 12),
//                   prefixIcon: Icon(Icons.link,color: Colors.pink.shade800,),
//
//                 ),
//                 controller: controllerurl,
//               ),
//               SizedBox(height: 32.0),
//               ElevatedButton(
//                 child: Text('Confirm'),
//                 onPressed: () {
//                   // TODO: Save event details to database or do something else
//                   // with the event details
//                   final docuser = FirebaseFirestore.instance.collection('sports').doc(widget.sport.id);
//                   docuser.update(
//                       {
//                         'clubhead' : controllerclubhead.text,
//                         'name' : controllername.text,
//                         'url' : controllerurl.text,
//                         'headphone' : controllerheadphone.text,
//                         'headmail' : controllerheadmail.text,
//                         'description': controllerdescription.text,
//                       }
//                   );
//                   //add redirecting page url
//                   Navigator.of(context).pop();
//                 },
//                 style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(Colors.blue),
//                     padding: MaterialStateProperty.all(EdgeInsets.all(14)),
//                     textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18))),
//
//               ),
//               SizedBox(height: 32.0),
//               ElevatedButton(
//                 child: Text('Delete'),
//                 onPressed: () {
//                   // TODO: Save event details to database or do something else
//                   // with the event details
//                   final doc = FirebaseFirestore.instance.collection('sports').doc(widget.sport.id);
//                   doc.delete();
//                   Navigator.of(context).pop();
//                 },
//                 style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(Colors.red),
//                     padding: MaterialStateProperty.all(EdgeInsets.all(14)),
//                     textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18))),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
