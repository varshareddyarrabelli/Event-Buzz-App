import 'package:eventbuzz/models/eventclass.dart';
import 'package:flutter/material.dart';

import '../models/clubclass.dart';

class viewevent1 extends StatefulWidget {
  final Clubs club;

  viewevent1(this.club);
  @override
  State<viewevent1> createState() => _viewevent1State();
}
class _viewevent1State extends State<viewevent1> {

  @override
  Widget build(BuildContext context) {
    String name = widget.club.name;
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
          backgroundColor: Color(0xff764abc),
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
                      Text('Club Head: '),
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
                      Text('Club Head Mail: '),
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
                      Text('Club Head Phone Number: '),
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


