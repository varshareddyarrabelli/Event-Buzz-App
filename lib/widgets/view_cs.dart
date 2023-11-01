import 'package:eventbuzz/widgets/view_clubs.dart';
import 'package:flutter/material.dart';
class View_cs extends StatefulWidget {
  const View_cs({Key? key}) : super(key: key);

  @override
  _View_csState createState() => _View_csState();
}

class _View_csState extends State<View_cs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clubs/Sports'),
        backgroundColor: Colors.pink.shade800,
        centerTitle: true,
      ),
      body:Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children : <Widget> [
            Card(
              margin: const EdgeInsets.fromLTRB(20,120,20,0),
              color: Colors.pink.shade600,
              child: Column(
                  children : <Widget>[

                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/view_clubs');
                      },

                      child: Center(
                        child: ListTile(
                          textColor: Colors.white,
                          title:
                          const Text('Clubs'),
                        ),
                      ),
                    ),

                  ]
              ),
            ),

            Card(
              margin: const EdgeInsets.fromLTRB(20,20,20,0),
              color: Colors.pink.shade600,
              child : new InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/view_sports');
                  },
                  child:   Center(
                    child: ListTile(
                      textColor: Colors.white,
                      title: const Text('Sports'),

                    ),
                  )
              ),
            ),




          ]
      ),
    );
  }
}
