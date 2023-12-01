
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/models/feedback.dart';
import 'package:eventbuzz/services/view_feedtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/eventclass.dart';
import '../services/database.dart';
String name = "";
int count = 0;
class View_Feed extends StatefulWidget {
  final Events event;
  View_Feed(this.event);
  @override
  State<View_Feed> createState() => _View_FeedState();
}
class _View_FeedState extends State<View_Feed> {
  @override
  Widget build(BuildContext context) {
    int total1 = 0;
    double avg_rating1 = 0;
    return StreamProvider<List<Feedbacks>>.value(
        value: DatabaseService().feedback,
        initialData: [],
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.event.name,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text('Feedbacks',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                SizedBox(height: 5,),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('feedback')
                      .snapshots(),
                  builder: (context, snapshots) {
                    int total = 0;
                    double avg_rating = 0;
                    final feedbacks = Provider.of<List<Feedbacks>>(context);
                    return (snapshots.connectionState ==
                        ConnectionState.waiting) ?
                    Center(
                      child: CircularProgressIndicator(),
                    ) : SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child:ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: feedbacks.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index)
                        {
                          if (feedbacks[index].feedback!="" && feedbacks[index].event_id==widget.event.id) {
                            count = 1;
                            return View_Feedtile(feedbacks[index].feedback);
                            // index++;
                          }
                          else if(count == 0 && index == feedbacks.length-1)
                          {
                            return Center(
                              child: Text('No Feedbacks Found'),
                            );
                          }
                          else
                          {
                            return SizedBox(height: 0,width: 0,);
                          }

                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10,),
                // Text('Rating',
                //   style: TextStyle(
                //     fontSize: 30,
                //     fontWeight: FontWeight.bold,
                //   ),),
                // Text('${avg_rating1}'),
                // Text('${total1}'),
                // SizedBox(height: 20,),
                // Text('${total}'),
                // Text('${avg_rating}'),
                //   Column(children: [
                //     SizedBox(height: 100000, child: Upcoming_EventList())]),
              ],

            ),
          ),

        )

    );
  }
}
