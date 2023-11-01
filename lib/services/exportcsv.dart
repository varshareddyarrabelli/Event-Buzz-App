
import 'dart:io';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/widgets/admin_home.dart';
import 'package:eventbuzz/widgets/club_heads.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:eventbuzz/models/eventclass.dart';

import '../models/eventclass.dart';
class ExportCsv extends StatefulWidget {
  final List<Events> events;

  ExportCsv(this .events);
  @override
  _ExportCsvState createState() => _ExportCsvState();
}

class _ExportCsvState extends State<ExportCsv> {


  @override
  Widget build(BuildContext context) {
    // createExcel();
    // return SizedBox(height: 0, width: 0,);
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.pink.shade800,
      title: Text('Create Excel'),
      centerTitle: true,
    ),
      body:Center(child:  ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.pink.shade600,
        ),
        child: Text('Create Excel'), onPressed:createExcel,),),);
  }
  Future<void> createExcel()async{
    final Workbook workbook = Workbook();
    final Worksheet sheet =workbook.worksheets[0];
    final db = FirebaseFirestore.instance;
    int j=1;
    sheet.getRangeByIndex(1, 1).setText('NAME');
    sheet.getRangeByIndex(1, 2).setText('CLUBNAME');
    sheet.getRangeByIndex(1, 3).setText('VENUE');
    sheet.getRangeByIndex(1, 4).setText('DATE');
    sheet.getRangeByIndex(1, 5).setText('STARTTIME');
    sheet.getRangeByIndex(1, 6).setText('ENDTIME');
    sheet.getRangeByIndex(1, 7).setText('DESCRIPTION');
    for(int i=2;i<widget.events.length+2;i++) {
      sheet.getRangeByIndex(i, 1).setText(widget.events[i-2].name);
      sheet.getRangeByIndex(i, 2).setText(widget.events[i-2].clubname);
      sheet.getRangeByIndex(i, 3).setText(widget.events[i-2].venue);
      sheet.getRangeByIndex(i, 4).setText(widget.events[i-2].date);
      sheet.getRangeByIndex(i, 5).setText(widget.events[i-2].starttime);
      sheet.getRangeByIndex(i, 6).setText(widget.events[i-2].endtime);
      sheet.getRangeByIndex(i, 7).setText(widget.events[i-2].description);

    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    if(kIsWeb){
      AnchorElement(href: 'data:application/octet-stream;charset=utf-161e;base64,${base64.encode(bytes)}')..setAttribute('download','Output.xlsx')..click();
    }
    else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);

    }
  }
}
