import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:gtg_tashkent/database.dart';
import 'package:url_launcher/url_launcher.dart';

class SponserScreen extends StatefulWidget {
  final String type;

  const SponserScreen({Key key, this.type}) : super(key: key);
  @override
  _SponserScreenState createState() => _SponserScreenState();
}

class _SponserScreenState extends State<SponserScreen> {
  Query _query;
  List<Widget> widgetIcon=[];
  List list;
  @override
  void initState() {
    Database.queryTeam().then((Query query) {
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
          print(snapshot.value["socials"][0]["name"]);
          Future<void> _onOpen(String link) async {
            if (await canLaunch(link)) {
              await launch(link);
            } else {
              throw 'Could not launch $link';
            }
          }
          return new Column(
            children: <Widget>[
              Row(
                children: [
                  Container(  padding: EdgeInsets.all(4),width: MediaQuery.of(context).size.width/2, child: Center(child: Image.network( map['photoUrl'],width: MediaQuery.of(context).size.width/2.5, height: MediaQuery.of(context).size.height/3, fit: BoxFit.cover,))),
                  Container(
                    padding: EdgeInsets.all(4),
                    width: MediaQuery.of(context).size.width/2,
                    child: Center(
                      child: Column(
                        children: [
                          Text('${map['name']}.'.trim(), maxLines:2, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                          Text('${map['title']}.'.trim(), style: TextStyle(color: Colors.green, fontSize: 17, fontStyle: FontStyle.italic),),
                          snapshot.value["socials"].length>0 ? Container(
                            decoration: new BoxDecoration(
                                color: Colors.blue,
                                borderRadius: new BorderRadius.all(Radius.circular(90.0))
                            ),
                            child: ListTile(
                              leading: Icon(
                                snapshot.value["socials"][0]["name"]=="Facebook" ? Typicons.facebook :  snapshot.value["socials"][0]["name"]=="Twitter" ? Typicons.twitter :  snapshot.value["socials"][0]["name"]=="Linkedin" ? Typicons.linkedin : Icons.web, color: Colors.white,),
                              title: Text(snapshot.value["socials"][0]["name"], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              onTap:(){
                                _onOpen(snapshot.value["socials"][0]["link"]);
                              },),
                          ):Container(),
                          SizedBox(
                            height: 4,
                          ),
                          snapshot.value["socials"].length>1 ? Container(
                            decoration: new BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: new BorderRadius.all(Radius.circular(90.0))
                            ),
                            child: ListTile(
                              leading: Icon(
                                snapshot.value["socials"][1]["name"]=="Facebook" ? Typicons.facebook :  snapshot.value["socials"][1]["name"]=="Twitter" ? Typicons.twitter :  snapshot.value["socials"][1]["name"]=="Linkedin" ? Typicons.linkedin : Icons.web, color: Colors.white,),
                              title: Text(snapshot.value["socials"][1]["name"], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              onTap:(){
                                _onOpen(snapshot.value["socials"][1]["link"]);
                              },
                            ),
                          ):Container(),
                          SizedBox(
                            height: 4,
                          ),
                          snapshot.value["socials"].length>2 ? Container(
                            decoration: new BoxDecoration(
                                color: Colors.green,
                                borderRadius: new BorderRadius.all(Radius.circular(90.0))
                            ),
                            child: ListTile(
                              leading: Icon(
                                snapshot.value["socials"][2]["name"]=="Facebook" ? Typicons.facebook :  snapshot.value["socials"][2]["name"]=="Twitter" ? Typicons.twitter :  snapshot.value["socials"][2]["name"]=="Linkedin" ? Typicons.linkedin : Icons.web, color: Colors.black,),
                              title: Text(snapshot.value["socials"][2]["name"], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              onTap:(){
                                _onOpen(snapshot.value["socials"][2]["link"]);
                              },
                            ),
                          ):Container(),
                          SizedBox(
                            height: 4,
                          ),
                          snapshot.value["socials"].length>3 ? Container(
                            decoration: new BoxDecoration(
                                color: Colors.green,
                                borderRadius: new BorderRadius.all(Radius.circular(90.0))
                            ),
                            child: ListTile(
                              leading: Icon(
                                snapshot.value["socials"][3]["name"]=="Facebook" ? Typicons.facebook :  snapshot.value["socials"][3]["name"]=="Twitter" ? Typicons.twitter :  snapshot.value["socials"][3]["name"]=="Linkedin" ? Typicons.linkedin : Icons.web, color: Colors.white,),
                              title: Text(snapshot.value["socials"][3]["name"], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              onTap:(){
                                _onOpen(snapshot.value["socials"][3]["link"]);
                              },
                            ),
                          ):Container(),
                          SizedBox(
                            height: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              new Divider(
                height: 4.0,
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
          title: Text("Team"),
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
