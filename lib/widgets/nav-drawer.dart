import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Clubs and Sports',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                ),
          ),

          Ink(
            color: Colors.brown,
            child: ListTile(
              title: Text('Clubs',
    style: TextStyle(color: Colors.white, fontSize: 25)),
              onTap: () => {},
            ),
          ),
          SizedBox(height: 10),
          Ink(
            color: Colors.brown,
            child: ListTile(
              title: Text('Sports',
                style: TextStyle(color: Colors.white, fontSize: 25)),
              onTap: () => {Navigator.of(context).pop()},
              selectedColor: Colors.red,
            ),
          ),
          SizedBox(height: 10),
          Ink(
            color: Colors.brown,
            child: ListTile(
              title: Text('Logout',
                style: TextStyle(color: Colors.white, fontSize: 25),),
              leading: Icon(Icons.input,
              color: Colors.white,),
              onTap: () => {Navigator.pushNamed(context, '/')},
            ),
          ),
        ],
      ),
    );
  }
}