import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gtg_tashkent/agenda/mobileScreen.dart';
import 'package:gtg_tashkent/database.dart';
Map result;
class AgendaHome extends StatefulWidget {
  @override
  _AgendaHomeState createState() => _AgendaHomeState();
}

class _AgendaHomeState extends State<AgendaHome> {
  final List<Widget> _tabItems = [Web(type: "Cloud"), Web(type: "Android"),  Web(type: "Web"), Web(type: "All")];
  int _activePage = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: _tabItems[_activePage],
        bottomNavigationBar: CurvedNavigationBar(
          index: _activePage,
          color: Colors.yellow,
          height: 50,
          buttonBackgroundColor: Colors.yellow,
          backgroundColor: Colors.white,
          items: <Widget>[
            Icon(Icons.cloud, size: 30, color: Colors.black,),
            Icon(Icons.smartphone, size: 30, color: Colors.black,),
            Icon(Icons.web, size: 30, color: Colors.black,),
            Icon(Icons.all_inclusive, size: 30, color: Colors.black,),
          ],
          onTap: (index) {
            setState(() {
              _activePage = index;
            });
            //Handle button tap
          },
        ),
    );
  }
}

class Web extends StatefulWidget {
  final String type;

  const Web({Key key, this.type}) : super(key: key);
  @override
  _WebState createState() => _WebState();
}

class _WebState extends State<Web> {
  Query _query;
  @override
  void initState() {
    Database.querySessions().then((Query query) {
      setState(() {
        _query = query;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildList(context, _query, result, widget.type);
  }
}