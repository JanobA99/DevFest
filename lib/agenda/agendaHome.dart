import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:gtg_tashkent/agenda/mobileScreen.dart';
import 'package:gtg_tashkent/database.dart';

class AgendaHome extends StatefulWidget {
  @override
  _AgendaHomeState createState() => _AgendaHomeState();
}

class _AgendaHomeState extends State<AgendaHome> {
  final List<Widget> _tabItems = [Cloud(), Mobile(), Web() ];
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
            Icon(Icons.add_shopping_cart, size: 30, color: Colors.black,),
            Icon(Icons.add, size: 30, color: Colors.black,),
            Icon(Icons.people, size: 30, color: Colors.black,),
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

class Cloud extends StatefulWidget {
  @override
  _CloudState createState() => _CloudState();
}

class _CloudState extends State<Cloud> {
String name;
String url;
Map result;
  Query _query;
  Future<Map> getDataSpeakers() async {
     result =await (await FirebaseDatabase.instance.reference().child("speakers").once()).value;
    return result;
  }
  @override
  void initState() {
    getDataSpeakers();
    Database.querySessions().then((Query query) {
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
        query: _query,
        itemBuilder: (
            BuildContext context,
            DataSnapshot snapshot,
            Animation<double> animation,
            int index,
            ) {
         Map map = snapshot.value;
         print(snapshot.key);
         List tag = map['tags'] ;
         List speakers = map['speakers'] ;
         if(tag!=null){
         if(tag[0]=="Cloud" && map['title'] !=null ){
           result.forEach((key, value) {
             if(speakers[0] == key){
               url=value["photoUrl"];
               name=value["name"];
             }
           });
          return new Column(
            children: <Widget>[
              new ListTile(
                leading: Image.network(url),
                title:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${map['title']}.'.trim(), maxLines:2, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                 Text(name, style: TextStyle(color: Colors.green, fontStyle: FontStyle.italic),)
                  ],
                ),
                subtitle: Text("${map['description']}".trim(),  maxLines: 2, style: TextStyle( fontSize: 10),),
                trailing: Text(""),
                onTap: () {

                },
              ),
              new Divider(
                height: 2.0,
              ),
            ],
          );
         }}else{
           return Container();
         }
         return Container();
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: Colors.yellow,
        title: Text("Cloud"),
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


class Web extends StatefulWidget {
  @override
  _WebState createState() => _WebState();
}

class _WebState extends State<Web> {
  String name;
  String url;
  Map result;
  Query _query;
  Future<Map> getDataSpeakers() async {
    result =await (await FirebaseDatabase.instance.reference().child("speakers").once()).value;
    return result;
  }
  @override
  void initState() {
    getDataSpeakers();
    Database.querySessions().then((Query query) {
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
        query: _query,
        itemBuilder: (
            BuildContext context,
            DataSnapshot snapshot,
            Animation<double> animation,
            int index,
            ) {
          Map map = snapshot.value;
          print(snapshot.key);
          List tag = map['tags'] ;
          List speakers = map['speakers'] ;
          if(tag!=null){
            if(tag[0]=="Android" && map['title'] !=null ){
              result.forEach((key, value) {
                if(speakers[0] == key){
                  url=value["photoUrl"];
                  name=value["name"];
                }
              });
              return new Column(
                children: <Widget>[
                  new ListTile(
                    leading: Image.network(url),
                    title:  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${map['title']}.'.trim(), maxLines:2, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                        Text(name, style: TextStyle(color: Colors.green, fontStyle: FontStyle.italic),)
                      ],
                    ),
                    subtitle: Text("${map['description']}".trim(),  maxLines: 2, style: TextStyle( fontSize: 10),),
                    trailing: Text(""),
                    onTap: () {

                    },
                  ),
                  new Divider(
                    height: 2.0,
                  ),
                ],
              );
            }}else{
            return Container();
          }
          return Container();
        },
      );
    }
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 35,
          backgroundColor: Colors.yellow,
          title: Text("Cloud"),
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
