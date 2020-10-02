
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:gtg_tashkent/database.dart';
import 'package:gtg_tashkent/home.dart';

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
        defaultChild: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            strokeWidth: 2.0,
          ),
        ),
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
                    Text('${map['name']}.'.trim(), maxLines:2, style: TextStyle( color: dark ? Colors.white : Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    Text('${map['title']}.'.trim(), style: TextStyle(color: Colors.green, fontStyle: FontStyle.italic),)
                  ],
                ),
                subtitle: Text("${map['shortBio']}".trim(),  maxLines: 2, style: TextStyle( fontSize: 10, color: dark ? Colors.white : Colors.black,),),
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
      backgroundColor: dark ? Colors.white12 : Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back, color: dark ? Colors.white : Colors.black,),
          ),
          toolbarHeight: 35,
          backgroundColor: dark ? Colors.black : Colors.yellow,
          title: Text("Speakers", style: TextStyle(color: dark ? Colors.white : Colors.black,),),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(dark
                  ? Icons.lightbulb_outline
                  : Icons.lightbulb_outline,
                color:  dark ? Colors.white : Colors.black,),
              onPressed: (){
                if(dark){
                  setState(() {
                    dark=false;
                  });
                }
                else{
                  setState(() {
                    dark=true;
                  });
                }
              },),
            IconButton(onPressed:(){},icon: Icon(Icons.share, color:  dark ? Colors.white : Colors.black,)),
          ],
        ),
        body: body
    );
  }
  }
