import 'package:flutter/material.dart';
import 'package:gtg_tashkent/Screens/teamScreen.dart';
import 'package:gtg_tashkent/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DEVFEST',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TeamListWidget(),
    );
  }
}
