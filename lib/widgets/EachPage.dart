import 'package:flutter/material.dart';

class EachPage extends StatefulWidget {

  final String message;
  final String image;

  EachPage(this.image, this.message);
  @override
  State<EachPage> createState() => _EachPageState();
}

class _EachPageState extends State<EachPage> {
  List<Event> _pastEvents = [];

  List<Event> _filteredEvents = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _filteredEvents = _pastEvents;
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 5,),
          Text(widget.message,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by name or venue',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _filterEvents('');
                  },
                ),
              ),
            ),
          ),
          Container(
            color: Colors.amberAccent,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    widget.image,
                    fit: BoxFit.scaleDown,
                    width: 200,
                    height: 200,),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }

  void _filterEvents(String query) {
    setState(() {
      _filteredEvents = _pastEvents
          .where((event) =>
      event.name.toLowerCase().contains(query.toLowerCase()) ||
          event.venue.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
class Event {
  final String name;
  final String venue;
  final double rating;

  Event({required this.name, required this.venue, required this.rating});
}