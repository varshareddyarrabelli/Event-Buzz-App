import 'dart:async';
import 'dart:core';
import 'package:eventbuzz/models/eventclass.dart';
import 'package:eventbuzz/services/upcoming_eventtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Club_upcoming_event_list extends StatefulWidget {
  final String name;

  Club_upcoming_event_list(this.name);
  @override
  _Club_upcoming_event_listState createState() => _Club_upcoming_event_listState();
}
DateTime now =DateTime.now();
int count =0;
class _Club_upcoming_event_listState extends State<Club_upcoming_event_list> {
  @override
  Widget build(BuildContext context) {

    final events = Provider.of<List<Events>>(context);

    return ListView.builder(
      itemCount: events.length,

      itemBuilder: (BuildContext context, int index)
      {

        final String stm, etm;
        stm = events[index].date + ' ' + events[index].starttime;
        etm = events[index].date + ' ' + events[index].endtime;

        DateTime sdt = DateTime.parse(stm);
        DateTime edt = DateTime.parse(etm);
        if (sdt.compareTo(now) > 0 && events[index].clubname == widget.name) {
          count = 1;
          return Upcoming_EventTile(event: events[index]);
          // index++;
        }
        else if(count == 0 && index == events.length-1)
        {
          return Center(
            child: Text('No Upcoming Events'),
          );
        }
        else
        {
          return Card();
        }

      },
    );
  }
}