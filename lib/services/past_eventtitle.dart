import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/models/eventclass.dart';
import 'package:eventbuzz/models/feedback.dart';
import 'package:eventbuzz/services/exportcsv.dart';
import 'package:flutter/material.dart';
import 'package:eventbuzz/widgets/EventViewPage.dart';
import 'package:rating_dialog/rating_dialog.dart';

import 'dart:core';

import '../models/sportclass.dart';

class Past_EventTile extends StatefulWidget {

  final Events event;
  Past_EventTile({ required this.event });

  @override
  State<Past_EventTile> createState() => _Past_EventTileState();
}
Future create1(Feedbacks feedback1) async {
  final docuser = FirebaseFirestore.instance.collection('feedback').doc();
  //club1.id = docuser.id;
  final json = feedback1.toJson();
  await docuser.set(json);

}

class _Past_EventTileState extends State<Past_EventTile> {
  final _firestore = FirebaseFirestore.instance;
  final controllerfeedback = TextEditingController();
  final controllerrating = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xff764abc),
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => viewevent(
                        widget.event
                    ),),
                );
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
                              widget.event.name,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          SizedBox(width: 10,),
                          Text(
                              widget.event.venue,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )
                          ),
                          SizedBox(width: 10,),
                          Text(
                              '${widget.event.starttime} - ${widget.event.endtime}',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )
                          ),

                          SizedBox(width: 10,),
                          Text(
                              widget.event.date,
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
                          // Image.network(event.url),
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.event.url),
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
              padding: const EdgeInsets.fromLTRB(20.0,0.0,20.0,10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  //child
                  // width: 40,
                  // color: Colors.grey[500],

                  // child: Icon(Icons.mode_edit_outline)

                  IconButton(
                      onPressed: (){
                        // Navigator.push(
                        //     context,MaterialPageRoute(builder: (context) => Edit_club(widget.club))
                        // );
                        final _dialog = RatingDialog(
                          initialRating: 0.0,

                          // your app's name?
                          title: Text(
                            'Rating Dialog',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // encourage your user to leave a high rating?
                          message: Text(
                            'Tap a star to set your rating.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 15),
                          ),
                          // your app's logo?
                          //image: const FlutterLogo(size: 100),
                          submitButtonText: 'Submit',
                          commentHint: 'Feedback comment',
                          onCancelled: () => print('cancelled'),
                          onSubmitted: (response) {
                            print('rating: ${response.rating}, comment: ${response.comment}');
                            final sport1 = Feedbacks(
                              feedback : response.comment,
                              rating : response.rating,
                              event_id: widget.event.id,
                            );
                            create1(sport1);
                          },
                        );

                        // show the dialog
                        showDialog(

                          context: context,
                          barrierDismissible: true, // set to false if you want to force a rating
                          builder: (context) => _dialog,
                        );
                      },
                      icon:   Icon(Icons.feedback_rounded,color: Colors.redAccent,)

                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}