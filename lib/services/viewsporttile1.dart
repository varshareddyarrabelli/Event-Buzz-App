import 'package:eventbuzz/models/clubclass.dart';
import 'package:eventbuzz/widgets/Home.dart';
import 'package:eventbuzz/widgets/Upcoming_Clubpage.dart';
import 'package:flutter/material.dart';
import '../models/sportclass.dart';
import '../widgets/Clubhome.dart';
import '../widgets/sporthome.dart';
class SportTile1 extends StatelessWidget {

  final Sports sport;
  SportTile1(this.sport);

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
      child: new InkWell(
        onTap: (){
          // print(1);
          // Clubhome(club.name);
          // Navigator.pushNamed(context, '/clubhome',arguments: club.name);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SportHome(
                    sport
                )),
          );
        },
        // MaterialPageRoute(
        //     builder: (context) => Clubhome(
        //      club.name
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
                        sport.name,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),),),
    );
  }
}