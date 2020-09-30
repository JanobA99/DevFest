import 'dart:async';

import 'package:firebase_database/firebase_database.dart';


class Database {
  static Future<Query> querySessions() async {
    return FirebaseDatabase.instance
        .reference()
        .child("sessions");
  }
  static Future<Query> queryDate() async {
    return FirebaseDatabase.instance
        .reference()
        .child("schedule");
  }
  static Future<Query> querySpeakers() async {
    return FirebaseDatabase.instance
        .reference()
        .child("speakers");
  }
  static Future<Query> queryTeam0() async {
    return FirebaseDatabase.instance
        .reference()
        .child("team").child("0").child("members");
  }
  static Future<Query> queryTeam1() async {
    return FirebaseDatabase.instance
        .reference()
        .child("team").child("1").child("members");
  }
  static Future<Query> querySponsors0() async {
    return FirebaseDatabase.instance
        .reference()
        .child("partners").child("0").child("logos");
  }
  static Future<Query> querySponsors1() async {
    return FirebaseDatabase.instance
        .reference()
        .child("partners").child("1").child("logos");
  }
}
