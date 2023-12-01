import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'head_Upcoming_Page.dart';
import 'head_Ongoing_Page.dart';
import 'head_Past_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eventbuzz/auth.dart';
class Clubhead_home extends StatefulWidget {
  final String? email;
  final String name;
  Clubhead_home(this.email,this.name);
  @override
  State<Clubhead_home> createState() => _Clubhead_homeState();
}

final PageController _pageController = PageController();


class _Clubhead_homeState extends State<Clubhead_home> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }
  Widget _signOutButton()
  {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }
  int _selectedIndex = 0;
  String selectedType = '';


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  onWillPop(context) async {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.name,
          ),
          backgroundColor: Colors.blue,
        ),

        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('',
                  style:TextStyle(
                    fontSize: 30,
                  ),),
              ),
              ListTile(
                leading: Icon(
                  Icons.notifications,
                ),
                title: const Text('Notifications'),
                onTap: () {
                  Navigator.pushNamed(context, '/headnotif');
                },
              ),
              _signOutButton(),
            ],
          ),
        ),
        body: Stack(
          children: [
            Center(
              // child: _pages.elementAt(_selectedIndex),
              child: PageView(
                controller: _pageController,
                children: [
                  head_Upcoming_Page('Upcoming Events',widget.email,widget.name),
                  head_Ongoing_Page('Ongoing Events',widget.email,widget.name),
                  head_Past_Page('Past Events',widget.email,widget.name),
                ],
              ),
            ),
            // ),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
          ],
          selectedItemColor: Colors.black,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

