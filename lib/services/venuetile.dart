import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/models/clubclass.dart';
import 'package:eventbuzz/widgets/edit_club.dart';
import 'package:flutter/material.dart';

import '../models/venueclass.dart';

class VenueTile extends StatefulWidget {

  final Venues venue;
  VenueTile( this.venue );

  @override
  State<VenueTile> createState() => _VenueTileState();
}

class _VenueTileState extends State<VenueTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.pink.shade400,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),

      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: InkWell(
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
                        widget.venue.name,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    SizedBox(width: 10,),
                    /* Text(
                          club.url,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )
                      ),
                      SizedBox(width: 10,),
                      // Text(
                      //     event.starttime,
                      //     style: TextStyle(
                      //       fontSize: 18.0,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.black,
                      //     )
                      // ),
                      // SizedBox(width: 10,),
                      // Text(
                      //     event.endtime,
                      //     style: TextStyle(
                      //       fontSize: 18.0,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.black,
                      //     )
                      // ),
                      // SizedBox(width: 10,),
                      // Text(
                      //     event.date,
                      //     style: TextStyle(
                      //       fontSize: 18.0,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.black,
                      //     )
                      // ),
                    ],
                  ),
                ),*/
                    SizedBox(width: 20,),
                    // Expanded(
                    //   flex: 3,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.end,
                    //     children: [
                    //       CircleAvatar(
                    //         //backgroundImage: NetworkImage('club.url'),
                    //         radius: 10.0,
                    //       ),
                    //     ],
                    //   ),
                    // ) ,
                  ],
                ),

              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
                child: Container(
                  // width: 40,
                  // color: Colors.grey[500],

                  // child: Icon(Icons.mode_edit_outline)
                  child: IconButton(
                      onPressed: (){
                        // Navigator.push(
                        //     context,MaterialPageRoute(builder: (context) => Edit_club(widget.club))
                        // );
                        final doc = FirebaseFirestore.instance.collection('venues').doc(widget.venue.id);
                        doc.delete();
                      },
                      icon:   Icon(Icons.delete,color: Colors.redAccent,)),
                ),
              ),
            ],
          ),),),
    );
  }
}