
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

  Widget buildList(BuildContext context, Query _query,  Map result, String type) {
    String name;
    String url;
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
for(int i=0; i<map["timeslots"].length; i++){
list5.add(map["timeslots"][i]["sessions"][0]["items"]);
  if(map["timeslots"][i]["sessions"].length>1){
    list5.add(map["timeslots"][i]["sessions"][1]["items"]);
  }
  if(map["timeslots"][i]["sessions"].length>2){
    list5.add(map["timeslots"][i]["sessions"][2]["items"]);
  }
}
List list=map["timeslots"];
Map map2=list.asMap();
List list2=[];
List list3=[];
List list4=[];
map2.forEach((key, value) {
  list2.add(value["sessions"]);
});
Map map3= list2.asMap();
map3.forEach((key, value) {
list3.add(value[0]);
if(value.length>1){
  list3.add(value[1]);
}
if(value.length>2){
  list3.add(value[2]);
}
});
Map map4 = list3.asMap();
map4.forEach((key, value) {
  list4.add(value["items"]);
});
print(list4);
print(list5);
          return new Column(
            children: <Widget>[
              new ListTile(
                  title: Text("dsjhs")
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
