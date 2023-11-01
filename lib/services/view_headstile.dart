import 'package:eventbuzz/models/clubclass.dart';
import 'package:flutter/material.dart';

class HeadTile extends StatefulWidget {

  final Clubs club;
  HeadTile(this.club);

  @override
  State<HeadTile> createState() => _HeadTileState();
}

class _HeadTileState extends State<HeadTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.pink.shade400,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: new InkWell(
        onTap: (){
          Navigator.pushNamed(context, '/viewevent');
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
                        widget.club.name,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    SizedBox(width: 10,),
                    Text(
                        widget.club.clubhead,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    SizedBox(width: 10,),
                    Text(
                        widget.club.headmail,
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

            ],
          ),),),
    );
  }
}