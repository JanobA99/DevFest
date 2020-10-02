import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
List<String> title=["Organizer", "What is a GDG?", "What is DevFest?", "Do I need to be a developer in order to participate?", "What is the agenda for the summit?", "Do I have to bring something with me?", "In what language are the talks and codelabs?",
"How much does it cost to attend the event?",
];
List<String> des=["GDG Tashkent is a proud organizer of DevFest Uzbekistan. Google Developers Group (GDG) Tashkent - is open and volunteer geek community who create exciting projects and share experience about Google technologies with a passion. Our goal is to organize space to connect the best industry experts with Uzbek audience to boost development of IT.",
"When you join a Google Developer Group, you'll have the opportunity to meet local developers with similar interests in technology. A GDG meetup event includes talks on a wide range of technical topics where you can learn new skills through hands-on workshops. The community prides itself on being an inclusive environment where everyone and anyone interested in tech - from beginner developers to experienced professionals - all are welcome to join.",
"DevFests are community-led developer events hosted by Google Developer Groups around the globe.",
"Yes, the event is targeted at developers, but you don't need to be a professional. Hobbyists are equally welcome!", "Please see the Agenda section of this app",
  "Bring your laptop with you if you want to try out the code you just learned. If you have table tennis racket bring it with you. It will be fun too.",
  "In order to reach a wide audience and attract speaker from all over the world the talks and codelabs are held in english. You will meet a multitude of nationalities and surly someone also speaking your language.",
"GDG DevFest is a free event, registration is required. You are responsible for making your own travel arrangement.",
];
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          toolbarHeight: 35,
          backgroundColor: Colors.yellow,
          title: Text("FAQ", style: TextStyle(color: Colors.black),),
          centerTitle: true,
          actions: [
            Icon(Icons.lightbulb_outline, color: Colors.black),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.share, color: Colors.black),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: title.length,
            itemBuilder: (BuildContext context, int index)=> buildExpansionTile(context, title[index], des[index])
        ),
      ),
    );
  }

  ExpansionTile buildExpansionTile(BuildContext context, String title, String des) {
    return ExpansionTile(
          title: new Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
          backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
          children: <Widget>[
           Container(padding: EdgeInsets.all(12),child: Text(des))
          ]
      );
  }
}