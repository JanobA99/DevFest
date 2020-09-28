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
}
