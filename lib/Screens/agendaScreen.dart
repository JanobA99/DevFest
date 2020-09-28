import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:gtg_tashkent/database.dart';
Map result;
Map timeMap;
class AgendaListWidget extends StatefulWidget {
  @override
  _AgendaListWidgetState createState() => _AgendaListWidgetState();
}

class _AgendaListWidgetState extends State<AgendaListWidget> {
  final List<Widget> _tabItems = [AgendaScreen(type: "Cloud"), AgendaScreen(type: "Android"),  AgendaScreen(type: "Web"), AgendaScreen(type: "All")];
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

class AgendaScreen extends StatefulWidget {
  final String type;

  const AgendaScreen({Key key, this.type}) : super(key: key);
  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
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

Widget buildList(BuildContext context, Query _query,  Map result, String type) {
  String name;
  String url2="https://firebasestorage.googleapis.com/v0/b/hoverboard-experimental.appspot.com/o/images%2Fbackgrounds%2Fregistration.jpg?alt=media&token=27328646-d323-4cca-904c-75f021bc3ffe";
  String url;
  String time;
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
      query: _query,
      itemBuilder: (
          BuildContext context,
          DataSnapshot snapshot,
          Animation<double> animation,
          int index,
          ) {
        Map map = snapshot.value;
        List tag = map['tags'] ;
        List speakers = map['speakers'] ;
        if(type!="All"){
          if(tag!=null){
            if(tag[0]==type && map['title'] !=null ){
              timeMap.forEach((key, value) {
                if("${snapshot.key}"=="$key"){
                  time=value;
                }
              });
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
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${time.substring(0,3)} ${time.substring(time.length-11,time.length-8)}"),
                        Text("${time.substring(time.length-8, time.length-2)}"),
                        Text("${time.substring(time.length-2)}mins", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                      ],
                    ),
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
          }}else{
          timeMap.forEach((key, value) {
            if("${snapshot.key}"=="$key"){
              time=value;
            }
          });
          result.forEach((key, value) {
            if(speakers!=null){
              if(speakers[0] == key){
                url=value["photoUrl"];
                name=value["name"];
              }}
          });
          return new Column(
            children: <Widget>[
              new ListTile(
                leading:Image.network(tag!=null ? url : "${map['image']==null ? url2: map['image']}",width: tag!=null ? null: MediaQuery.of(context).size.width/1.38, fit: BoxFit.cover,),
                title: tag!=null ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${map['title']}.'.trim(), maxLines:2, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                    Text(name, style: TextStyle(color: Colors.green, fontStyle: FontStyle.italic),)
                  ],
                ) : Container(),
                subtitle: tag!=null ? Text("${map['description']}".trim(),  maxLines: 2, style: TextStyle( fontSize: 10),):Container(),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${time.substring(0,3)} ${time.substring(time.length-11,time.length-9)}"),
                    Text("${time.substring(time.length-8, time.length-3)}"),
                    Text("${time.substring(time.length-3)}mins", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                  ],
                ),
                onTap: () {

                },
              ),
              new Divider(
                height: 2.0,
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
  return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: Colors.yellow,
        title: Text(type=="Android"? "Mobile": type),
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