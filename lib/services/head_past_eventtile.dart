import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/models/eventclass.dart';
import 'package:eventbuzz/widgets/view_feed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:core';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';

import '../models/feedback.dart';
import '../widgets/EventViewPage.dart';
import 'database.dart';
class Head_Past_EventTile extends StatefulWidget {

  final Events event;
  Head_Past_EventTile({ required this.event });

  @override
  State<Head_Past_EventTile> createState() => _Head_Past_EventTileState();
}

class _Head_Past_EventTileState extends State<Head_Past_EventTile> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Feedbacks>>.value(
      value: DatabaseService().feedback,
      initialData: [],
      child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.blue,
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
                        )),
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
                                widget.event.starttime,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )
                            ),
                            SizedBox(width: 10,),
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
                        itemBuilder: (BuildContext context, int index) {
                          if(index == feedbacks.length - 1  )
                          {
                            int t1 = 0;
                            double t2 = 0;
                            for(int k =0;k<feedbacks.length;k++)
                            {
                              if(feedbacks[k].event_id == widget.event.id)
                              {
                                t1++;
                                t2 = t2 + feedbacks[k].rating;
                              }
                            }
                            print('${t1}');
                            print('${t2}');
                            if(t1==0)
                            {
                              return Center(child: Text('No Ratings'));
                            }
                            else {
                              print('${t2 / t1}');
                              String t3 = (t2/t1).toStringAsFixed(2);
                              return Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${t3} ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    PannableRatingBar(
                                      rate: t2/t1,
                                      items : List.generate(5, (index) =>
                                      const RatingWidget(
                                        selectedColor :Colors.amber,
                                        unSelectedColor : Colors.grey,
                                        child : Icon(
                                          Icons.star,
                                          size :30,
                                        ),
                                      )
                                      ),
                                      onChanged: (value) {
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(5, 10, 0,0),
                                      child: Text('${t1} reviews',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),

                                      ),
                                    ),
                                  ],
                                ),);
                            }
                          }
                          return SizedBox(height: 0,width: 0,);
                        }
                    ),
                  );
                },
              ),
              Padding(

                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => View_Feed( widget.event
                            )),
                      );
                    },
                    child: Text('View Feedback')),
              ),

            ],
          )
      ),
    );
  }
}

// class StarDisplayWidget extends StatelessWidget {
//   final double value;
//   final Widget filledStar;
//   final Widget unfilledStar;
//   const StarDisplayWidget({
//     //Key key,
//     this.value = 0,
//     required this.filledStar,
//     required this.unfilledStar,
//   })  : assert(value != null);
//         //super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: List.generate(5, (index) {
//         return index < value ? filledStar : unfilledStar;
//       }),
//     );
//   }
// }
// class StarDisplay extends StarDisplayWidget {
//   const StarDisplay({ double value = 0})
//       : super(
//  //   key: key,
//     value: value,
//     filledStar: const Icon(Icons.star),
//     unfilledStar: const Icon(Icons.star_border),
//   );
// }