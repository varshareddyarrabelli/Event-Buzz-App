import 'dart:async';
import 'dart:core';
import 'package:eventbuzz/models/eventclass.dart';
import 'package:eventbuzz/services/past_eventtitle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Club_past_event_list extends StatefulWidget {

  final Events event;
  final String name;

  Club_past_event_list(this.event,this.name);
  @override
  _Club_past_event_listState createState() => _Club_past_event_listState();
}
DateTime now =DateTime.now();
int count =0;
class _Club_past_event_listState extends State<Club_past_event_list> {
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
    final String stm, etm;
    stm = widget.event.date + ' ' + widget.event.starttime;
    etm = widget.event.date + ' ' + widget.event.endtime;
    DateTime sdt = DateTime.parse(stm);
    DateTime edt = DateTime.parse(etm);
    if (edt.compareTo(now) < 0 && widget.event.clubname == widget.name) {
      count = 1;
      return Past_EventTile(event: widget.event);
      // index++;
    }
    return Card();
  }
}