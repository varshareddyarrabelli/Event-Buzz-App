import 'package:eventbuzz/models/eventclass.dart';
import 'package:flutter/material.dart';

class viewevent extends StatefulWidget {
  final Events event;

  viewevent(this.event);
  @override
  State<viewevent> createState() => _vieweventState();
}
class _vieweventState extends State<viewevent> {

  @override
  Widget build(BuildContext context) {
    String name = widget.event.name;
    String starttime = widget.event.starttime;
    String endtime = widget.event.endtime;
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
            Image.network(widget.event.url,
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
                    children: <Widget>[
                      Icon(Icons.access_time),
                      SizedBox(width: 8.0),
                      Text('${starttime} - ${endtime}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),)
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children:<Widget>[
                      Icon(Icons.calendar_today),
                      SizedBox(width: 8.0),
                      Text('Date: '),
                      Text(widget.event.date,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children:<Widget>[
                      Icon(Icons.location_on),
                      SizedBox(width: 8.0),
                      Text('Venue: '),
                      Text(widget.event.venue,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text('Description ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(height: 10,),
                  Text( widget.event.description,
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


