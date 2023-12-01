import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbuzz/models/eventclass.dart';
import 'package:eventbuzz/models/clubclass.dart';
import 'package:eventbuzz/models/venueclass.dart';
import 'package:eventbuzz/models/sportclass.dart';

import '../models/feed.dart';
import '../models/feedback.dart';

class DatabaseService {

  final String? uid;

  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference eventcollection = FirebaseFirestore.instance.collection('events');
  final CollectionReference clubcollection = FirebaseFirestore.instance.collection('clubs');
  final CollectionReference sportcollection = FirebaseFirestore.instance.collection('sports');
  final CollectionReference venuecollection = FirebaseFirestore.instance.collection('venues');
  final CollectionReference feedbackcollection = FirebaseFirestore.instance.collection('feedback');
  final CollectionReference feedscollection = FirebaseFirestore.instance.collection('feeds');

  Future<void> updateUserData(String starttime, String name, String endtime, String venue, String url, String description, String clubname,String date, String id,int flag1,int flag2, String id2, String list1, String dtt) async {
    return await eventcollection.doc(uid).set({
      'starttime': starttime,
      'name': name,
      'endtime': endtime,
      'url': url,
      'venue': venue,
      'description': description,
      'clubname': clubname,
      'date': date,
      'id': id,
      'id2': id2,
      'flag1':flag1,
      'flag2':flag2,
      'list1':list1,
      'dtt':dtt,
    });
  }

  // brew list from snapshot
  List<Events> _eventListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      //print(doc.data);
      return Events(
        name:   doc['name'] ?? '',
        starttime: doc['starttime'] ?? 0,
        endtime: doc['endtime'] ?? '0',
        email: doc['email']??'0',
        venue: doc['venue']??'0',
        description: doc['description']??'0',
        url: doc['url']??'0',
        clubname: doc['clubname']??'0',
        date: doc['date']??'0',
        id: doc['id']??'0',
        flag1: doc['flag1']??'0',
        flag2: doc['flag2']??'0',
        id2: doc['id2']??'0',
        list1: doc['list1']??'0',
        dtt: doc['dtt']??'0',
      );
    }).toList();
  }
  List<Clubs> _clubListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      //print(doc.data);
      return Clubs(
        name:   doc['name'] ?? '0',
        clubhead: doc['clubhead'] ?? '0',
        headmail: doc['headmail'] ?? '0',
        headphone: doc['headphone']??'0',
        url: doc['url']??'0',
        description: doc['description']??'0',
        id: doc['id']??'0',
        list1: doc['list1']??'0',
      );
    }).toList();
  }
  List<Sports> _sportListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      //print(doc.data);
      return Sports(
        name:   doc['name'] ?? '0',
        clubhead: doc['clubhead'] ?? '0',
        headmail: doc['headmail'] ?? '0',
        headphone: doc['headphone']??'0',
        url: doc['url']??'0',
        description: doc['description']??'0',
        id: doc['id']??'0',
        list1: doc['list1']??'0',
      );
    }).toList();
  }

  // get brews stream
  List<Venues> _venueListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      //print(doc.data);
      return Venues(
        name:   doc['name'] ?? '',
        id: doc['id']??'',
      );
    }).toList();
  }
  List<Feedbacks> _feedbackListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      //print(doc.data);
      return Feedbacks(
        feedback:   doc['feedback'] ?? '0',
        event_id: doc['event_id'] ?? '0',
        rating: doc['rating'] ?? '0',

      );
    }).toList();
  }

  List<Feeds> _feedsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      //print(doc.data);
      return Feeds(
        feedback:   doc['feedback'] ?? '0',
        name: doc['name'] ?? '0',
        mail: doc['mail'] ?? '0',
        flag: doc['flag'] ?? '0',
        dtt: doc['dtt'] ?? '0',

      );
    }).toList();
  }

  // get brews stream
  Stream<List<Events>> get events {
    return eventcollection.snapshots()
        .map(_eventListFromSnapshot);
  }
  Stream<List<Clubs>> get clubs {
    return clubcollection.snapshots()
        .map(_clubListFromSnapshot);
  }
  Stream<List<Sports>> get sports {
    return sportcollection.snapshots()
        .map(_sportListFromSnapshot);
  }
  Stream<List<Venues>> get venues {
    return venuecollection.snapshots()
        .map(_venueListFromSnapshot);
  }
  Stream<List<Feedbacks>> get feedback {
    return feedbackcollection.snapshots()
        .map(_feedbackListFromSnapshot);
  }
  Stream<List<Feeds>> get feeds {
    return feedscollection.snapshots()
        .map(_feedsListFromSnapshot);
  }

}