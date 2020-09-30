import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gtg_tashkent/database.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorsScreen extends StatefulWidget {

  @override
  _SponsorsScreenState createState() => _SponsorsScreenState();
}

class _SponsorsScreenState extends State<SponsorsScreen> {
  Query _query;
  List<Widget> widgetIcon=[];
  List list;
  @override
  void initState() {
    Database.querySponsors1().then((Query query) {
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

          Future<void> _onOpen(String link) async {
            if (await canLaunch(link)) {
              await launch(link);
            } else {
              throw 'Could not launch $link';
            }
          }
          return Container(
            padding: EdgeInsets.all(9),
            child: new Column(
              children: <Widget>[
GestureDetector(
  child:   SvgPicture.network("https://gdgtashkent.co/${map['logoUrl']}",

    height: MediaQuery.of(context).size.height/9,

    placeholderBuilder: (BuildContext context) => Container(

      padding: const EdgeInsets.all(30.0),

      child: const CircularProgressIndicator()),),
  onTap: () {
    _onOpen(map["url"]);
  },
)
              ],
            ),
          );
        },
      );
    }
    Future<void> _onOpen(String link) async {
      if (await canLaunch(link)) {
        await launch(link);
      } else {
        throw 'Could not launch $link';
      }
    }
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 35,
          backgroundColor: Colors.yellow,
          title: Text("Program Committee"),
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
        body: Stack(children:[
          Container(
              child: GestureDetector(child: Image.asset("assets/logo.png"), onTap: (){
                _onOpen("https://www.meetup.com/GDG-Tashkent/");
              },)),
          Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/5),
              child: body)
        ])
    );
  }
}
