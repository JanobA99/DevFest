
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


Widget buildList2(BuildContext context, Query _query,  Map result, String type) {

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
          Map map=snapshot.value;
          List list5=[];
          List list6=[];
          for(int i=0; i<map["timeslots"].length; i++){
            list5.add(map["timeslots"][i]["sessions"][0]["items"][0]);
              String hourStart=map["timeslots"][i]["startTime"].toString().substring(0,2);
              String minutStart=map["timeslots"][i]["startTime"].toString().substring(3,5);
              String hourEnd=map["timeslots"][i]["endTime"].toString().substring(0,2);
              String minutEnd=map["timeslots"][i]["endTime"].toString().substring(3,5);
            list6.add("${map["timeslots"][i]["startTime"]} ${(int.parse(hourEnd)-int.parse(hourStart))*60 + (int.parse(minutEnd)-int.parse(minutStart))}");
            if(map["timeslots"][i]["sessions"][0]["items"].length>1){
              list5.add(map["timeslots"][i]["sessions"][0]["items"][1]);
              String hourStart=map["timeslots"][i]["startTime"].toString().substring(0,2);
              String minutStart=map["timeslots"][i]["startTime"].toString().substring(3,5);
              String hourEnd=map["timeslots"][i]["endTime"].toString().substring(0,2);
              String minutEnd=map["timeslots"][i]["endTime"].toString().substring(3,5);
              list6.add("${map["timeslots"][i]["startTime"]} ${(int.parse(hourEnd)-int.parse(hourStart))*60 + (int.parse(minutEnd)-int.parse(minutStart))}");
            }
            if(map["timeslots"][i]["sessions"].length>1){
              list5.add(map["timeslots"][i]["sessions"][1]["items"][0]);
              String hourStart=map["timeslots"][i]["startTime"].toString().substring(0,2);
              String minutStart=map["timeslots"][i]["startTime"].toString().substring(3,5);
              String hourEnd=map["timeslots"][i]["endTime"].toString().substring(0,2);
              String minutEnd=map["timeslots"][i]["endTime"].toString().substring(3,5);
              list6.add("${map["timeslots"][i]["startTime"]} ${(int.parse(hourEnd)-int.parse(hourStart))*60 + (int.parse(minutEnd)-int.parse(minutStart))}");
              if(map["timeslots"][i]["sessions"][1]["items"].length>1){
                list5.add(map["timeslots"][i]["sessions"][1]["items"][1]);
                String hourStart=map["timeslots"][i]["startTime"].toString().substring(0,2);
                String minutStart=map["timeslots"][i]["startTime"].toString().substring(3,5);
                String hourEnd=map["timeslots"][i]["endTime"].toString().substring(0,2);
                String minutEnd=map["timeslots"][i]["endTime"].toString().substring(3,5);
                list6.add("${map["timeslots"][i]["startTime"]} ${(int.parse(hourEnd)-int.parse(hourStart))*60 + (int.parse(minutEnd)-int.parse(minutStart))}");
              }
            }
            if(map["timeslots"][i]["sessions"].length>2){
              list5.add(map["timeslots"][i]["sessions"][2]["items"][0]);
              String hourStart=map["timeslots"][i]["startTime"].toString().substring(0,2);
              String minutStart=map["timeslots"][i]["startTime"].toString().substring(3,5);
              String hourEnd=map["timeslots"][i]["endTime"].toString().substring(0,2);
              String minutEnd=map["timeslots"][i]["endTime"].toString().substring(3,5);
              list6.add("${map["timeslots"][i]["startTime"]} ${(int.parse(hourEnd)-int.parse(hourStart))*60 + (int.parse(minutEnd)-int.parse(minutStart))}");
              if(map["timeslots"][i]["sessions"][2]["items"].length>1){
                list5.add(map["timeslots"][i]["sessions"][2]["items"][1]);
                String hourStart=map["timeslots"][i]["startTime"].toString().substring(0,2);
                String minutStart=map["timeslots"][i]["startTime"].toString().substring(3,5);
                String hourEnd=map["timeslots"][i]["endTime"].toString().substring(0,2);
                String minutEnd=map["timeslots"][i]["endTime"].toString().substring(3,5);
                list6.add("${map["timeslots"][i]["startTime"]} ${(int.parse(hourEnd)-int.parse(hourStart))*60 + (int.parse(minutEnd)-int.parse(minutStart))}");
              }
            }
          }
          return new Column(
            children: <Widget>[
              new ListTile(
                  title: Text(list6[index])
              ),
              new Divider(
                height: 2.0,
              ),
            ],
          );
        }
    );
  }
  return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: Colors.yellow,
        title: Text(type),
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
