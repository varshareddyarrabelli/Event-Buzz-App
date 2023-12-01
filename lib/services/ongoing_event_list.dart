import 'dart:async';
import 'dart:core';
import 'package:eventbuzz/models/eventclass.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ongoing_eventtile.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}
DateTime now = DateTime.now();

class _EventListState extends State<EventList> {
  _getDateTime() {
    setState(() {
      now = DateTime.now();
    });
  }
  @override
  void initState() {
    _getDateTime();
    super.initState();
    Timer.periodic(Duration(seconds: 1), (_) => _getDateTime());
  }
  @override
  Widget build(BuildContext context) {

    final events = Provider.of<List<Events>>(context);
int count = 0;
    return ListView.builder(
      itemCount: events.length,

      itemBuilder: (BuildContext context, int index)
      {
        final String stm, etm;
        stm = events[index].date + ' ' + events[index].starttime;
        etm = events[index].date + ' ' + events[index].endtime;
        DateTime sdt = DateTime.parse(stm);
        DateTime edt = DateTime.parse(etm);
        if (sdt.compareTo(now) < 0 && edt.compareTo(now)>0) {
          count = 1;
          return Ongoing_EventTile(event: events[index]);
          // index++;
        }
        else if(count == 0 && index == events.length-1)
        {
          return Center(
            child: Text('No Ongoing Events'),
          );
        }
        else {
          return Card();
        }

      },
    );

  }
}