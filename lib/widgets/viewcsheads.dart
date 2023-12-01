import 'package:eventbuzz/widgets/view_clubs.dart';
import 'package:flutter/material.dart';

class csheads extends StatefulWidget {
  const csheads({Key? key}) : super(key: key);

  @override
  _csheadsState createState() => _csheadsState();
}

class _csheadsState extends State<csheads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heads Details'),
        backgroundColor: Colors.pink.shade800,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                margin: const EdgeInsets.fromLTRB(30, 120, 20, 0),
                color: Colors.pink.shade600,
                child: SizedBox(
                    width: 300,
                    height: 50,
                    // child: Column(
                    // children : <Widget>[

                    child: new InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/club_heads');
                      },
                      child: Center(
                        child: ListTile(
                            textColor: Colors.white,
                            title: new Center(
                              child: const Text('View Club Heads'),
                            )),
                      ),
                    )),
              ),
              // ),

              Card(
                margin: const EdgeInsets.fromLTRB(30, 20, 20, 0),
                color: Colors.pink.shade600,
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: new InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/sports_heads');
                      },
                      child: Center(
                        child: ListTile(
                            textColor: Colors.white,
                            title: new Center(
                              child: const Text('View Sports Heads'),
                            )),
                      )),
                ),
              )
            ]),
      ),
    );
  }
}
