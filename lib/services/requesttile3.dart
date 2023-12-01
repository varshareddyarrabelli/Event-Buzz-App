import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/eventclass.dart';
import '../models/feed.dart';
import '../widgets/EventViewPage.dart';

class AboutWidget extends StatefulWidget {
  final Events event;
  AboutWidget(this.event);

  @override
  State<AboutWidget> createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Approve Event?'),
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Are you sure you want to Approve this Request?'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Confirm'),
          onPressed: () {
            final sport1 = Feeds(
              feedback: 'This Delete request is Approved',
              name: widget.event.name,
              mail: widget.event.email,
              flag: 0,
              dtt: DateTime.now().toString(),
            );
            create(sport1);
            final docuser = FirebaseFirestore.instance.collection('events').doc(widget.event.id);
            docuser.delete();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

  }
}
Future create(Feeds event1) async {
  final docuser = FirebaseFirestore.instance.collection('feeds').doc();
  final json = event1.toJson();
  await docuser.set(json);
}
class Deny extends StatefulWidget {
  final Events event;
  Deny(this.event);
  @override
  State<Deny> createState() => _DenyState();
}

class _DenyState extends State<Deny> {
  @override
  Widget build(BuildContext context) {
    final controllerfeedback = TextEditingController();
    return AlertDialog(
      title: Text('Deny Event?'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Are you sure you want to deny this event?'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Give Your Feedback',
          ),
          controller: controllerfeedback,
        ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Confirm'),
          onPressed: () {
            final sport1 = Feeds(
              feedback: controllerfeedback.text,
              name: widget.event.name,
              mail: widget.event.email,
              flag: 1,
              dtt: DateTime.now().toString(),
            );
            if (controllerfeedback.text.isNotEmpty) {
              create(sport1);
              final docuser = FirebaseFirestore.instance.collection('events')
                  .doc(widget.event.id);
              docuser.update(
                  {
                    'flag1': 1,
                  }
              );
              Navigator.of(context).pop();
            }
          }
        ),
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}


class Requests3 extends StatefulWidget {
  final Events event;
  final String message;
  Requests3(this.event,this.message);

  @override
  State<Requests3> createState() => _Requests3State();
}

class _Requests3State extends State<Requests3> {
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
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => viewevent(
                widget.event
            )
            ),);
                },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(width: 10,),
                          Text(
                              widget.message,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )
                          ),
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
                              widget.event.starttime,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )
                          ),
                          Text('-'),
                          Text(
                              widget.event.endtime,
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
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.event.url),
                            radius: 40.0,
                          ),
                        ],
                      ),
                    ) ,
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(

                        onPressed: ()=> showDialog(
                          context: context,
                          builder: (context) => AboutWidget(widget.event),
                        ),

                        icon:   Icon(Icons.check),
                      ),
                      IconButton(

                        onPressed: ()=> showDialog(
                          context: context,
                          builder: (context) => Deny(widget.event),
                        ),

                        icon:   Icon(FontAwesomeIcons.xmark),
                      ),
                    ]

                )
              ],
            ),
          ),
        )
    );;
  }
}
