import 'package:eventbuzz/models/eventclass.dart';
import 'package:flutter/material.dart';

import '../models/clubclass.dart';
import '../models/sportclass.dart';

class viewevent2 extends StatefulWidget {
  final Sports club;

  viewevent2(this.club);
  @override
  State<viewevent2> createState() => _viewevent2State();
}
class _viewevent2State extends State<viewevent2> {

  @override
  Widget build(BuildContext context) {
    String name = widget.club.name;
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
        backgroundColor: Colors.pink.shade800,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAuHlbrw17HuaoiWxbtCDztBZ6sZv9f_P01Ik4uFZLYgmU3yfEW4iRk2l9C5C-ivrNiGw&usqp=CAU",
            Image.network(widget.club.url,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 16.0),
                  Row(
                    children:<Widget>[
                      SizedBox(width: 8.0),
                      Text('Sport Head: '),
                      Text(widget.club.clubhead,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children:<Widget>[
                      SizedBox(width: 8.0),
                      Text('Sport Head Mail: '),
                      Text(widget.club.headmail,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children:<Widget>[
                      SizedBox(width: 8.0),
                      Text('Sport Head Phone Number: '),
                      Text(widget.club.headphone,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text('Description ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(height: 10,),
                  Text( widget.club.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}


