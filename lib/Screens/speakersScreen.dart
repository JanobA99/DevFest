
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:gtg_tashkent/database.dart';

class SpeakersScreen extends StatefulWidget {
  final String type;

  const SpeakersScreen({Key key, this.type}) : super(key: key);
  @override
  _SpeakersScreenState createState() => _SpeakersScreenState();
}

class _SpeakersScreenState extends State<SpeakersScreen> {
  Query _query;

  @override
  void initState() {
    Database.querySpeakers().then((Query query) {
      setState(() {
        _query = query;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = new ListView(
      children: <Widget>[
        new ListTile(
          title: new Text("The list is empty..."),
        )
      ],
    );
    if (_query != null) {
      body = new FirebaseAnimatedList(
        shrinkWrap: true,
        query: _query,
        itemBuilder: (
            BuildContext context,
            DataSnapshot snapshot,
            Animation<double> animation,
            int index,
            ) {
          Map map = snapshot.value;
          return new Column(
            children: <Widget>[
              new ListTile(
                leading:Image.network( map['photoUrl'],),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${map['name']}.'.trim(), maxLines:2, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    Text('${map['title']}.'.trim(), style: TextStyle(color: Colors.green, fontStyle: FontStyle.italic),)
                  ],
                ),
                subtitle: Text("${map['shortBio']}".trim(),  maxLines: 2, style: TextStyle( fontSize: 10),),
                onTap: () {

                },
              ),
              new Divider(
                height: 2.0,
              ),
            ],
          );
        },
      );
    }
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 35,
          backgroundColor: Colors.yellow,
          title: Text("Speakers"),
          centerTitle: true,
          actions: [
            Icon(Icons.lightbulb_outline),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.share),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: body
    );
  }
  }
