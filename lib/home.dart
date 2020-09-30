import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtg_tashkent/Screens/sponsorsScreen.dart';
import 'package:gtg_tashkent/Screens/teamScreen.dart';
import 'package:gtg_tashkent/Screens/agendaScreen.dart';
import 'package:gtg_tashkent/Screens/speakersScreen.dart';
import 'package:gtg_tashkent/database.dart';
import 'package:progress_indicator_button/progress_button.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<Bubble> bubbles;
  final int numberOfBubbles = 100;
  final Color color = Colors.deepPurpleAccent;
  final double maxBubbleSize = 9.0;

  Future<Map> getDataSpeakers() async {
    result = (await FirebaseDatabase.instance.reference().child("speakers").once())
        .value;
    return result;
  }
  Future<Map> getDataTime() async {
   await Database.queryDate().then((Query query) {
      query.once().then((DataSnapshot snapshot){
        Map map2 = snapshot.value;
        List list5=[];
        List list6=[];
      map2.forEach((key, value) {
        Map map=value;
        for(int i=0; i<map["timeslots"].length; i++){
          list5.add(map["timeslots"][i]["sessions"][0]["items"][0]);
          String hourStart=map["timeslots"][i]["startTime"].toString().substring(0,2);
          String minutStart=map["timeslots"][i]["startTime"].toString().substring(3,5);
          String hourEnd=map["timeslots"][i]["endTime"].toString().substring(0,2);
          String minutEnd=map["timeslots"][i]["endTime"].toString().substring(3,5);
          list6.add("${map["dateReadable"]} ${map["timeslots"][i]["startTime"]} ${(int.parse(hourEnd)-int.parse(hourStart))*60 + (int.parse(minutEnd)-int.parse(minutStart))}");
          if(map["timeslots"][i]["sessions"][0]["items"].length>1){
            list5.add(map["timeslots"][i]["sessions"][0]["items"][1]);
            String hourStart=map["timeslots"][i]["startTime"].toString().substring(0,2);
            String minutStart=map["timeslots"][i]["startTime"].toString().substring(3,5);
            String hourEnd=map["timeslots"][i]["endTime"].toString().substring(0,2);
            String minutEnd=map["timeslots"][i]["endTime"].toString().substring(3,5);
            list6.add("${map["dateReadable"]} ${map["timeslots"][i]["startTime"]} ${(int.parse(hourEnd)-int.parse(hourStart))*60 + (int.parse(minutEnd)-int.parse(minutStart))}");
          }
          if(map["timeslots"][i]["sessions"].length>1){
            list5.add(map["timeslots"][i]["sessions"][1]["items"][0]);
            String hourStart=map["timeslots"][i]["startTime"].toString().substring(0,2);
            String minutStart=map["timeslots"][i]["startTime"].toString().substring(3,5);
            String hourEnd=map["timeslots"][i]["endTime"].toString().substring(0,2);
            String minutEnd=map["timeslots"][i]["endTime"].toString().substring(3,5);
            list6.add("${map["dateReadable"]} ${map["timeslots"][i]["startTime"]} ${(int.parse(hourEnd)-int.parse(hourStart))*60 + (int.parse(minutEnd)-int.parse(minutStart))}");
            if(map["timeslots"][i]["sessions"][1]["items"].length>1){
              list5.add(map["timeslots"][i]["sessions"][1]["items"][1]);
              String hourStart=map["timeslots"][i]["startTime"].toString().substring(0,2);
              String minutStart=map["timeslots"][i]["startTime"].toString().substring(3,5);
              String hourEnd=map["timeslots"][i]["endTime"].toString().substring(0,2);
              String minutEnd=map["timeslots"][i]["endTime"].toString().substring(3,5);
              list6.add("${map["dateReadable"]} ${map["timeslots"][i]["startTime"]} ${(int.parse(hourEnd)-int.parse(hourStart))*60 + (int.parse(minutEnd)-int.parse(minutStart))}");
            }
          }
          if(map["timeslots"][i]["sessions"].length>2){
            list5.add(map["timeslots"][i]["sessions"][2]["items"][0]);
            String hourStart=map["timeslots"][i]["startTime"].toString().substring(0,2);
            String minutStart=map["timeslots"][i]["startTime"].toString().substring(3,5);
            String hourEnd=map["timeslots"][i]["endTime"].toString().substring(0,2);
            String minutEnd=map["timeslots"][i]["endTime"].toString().substring(3,5);
            list6.add("${map["dateReadable"]} ${map["timeslots"][i]["startTime"]} ${(int.parse(hourEnd)-int.parse(hourStart))*60 + (int.parse(minutEnd)-int.parse(minutStart))}");
            if(map["timeslots"][i]["sessions"][2]["items"].length>1){
              list5.add(map["timeslots"][i]["sessions"][2]["items"][1]);
              String hourStart=map["timeslots"][i]["startTime"].toString().substring(0,2);
              String minutStart=map["timeslots"][i]["startTime"].toString().substring(3,5);
              String hourEnd=map["timeslots"][i]["endTime"].toString().substring(0,2);
              String minutEnd=map["timeslots"][i]["endTime"].toString().substring(3,5);
              list6.add("${map["dateReadable"]} ${map["timeslots"][i]["startTime"]} ${(int.parse(hourEnd)-int.parse(hourStart))*60 + (int.parse(minutEnd)-int.parse(minutStart))}");
            }
          }
        }
      });
        timeMap=Map.fromIterables(list5, list6);
      });
    });
    return timeMap;
  }
  @override
  void initState() {
    super.initState();
    // Initialize bubbles
    bubbles = List();
    int i = numberOfBubbles;
    while (i > 0) {
      bubbles.add(Bubble(color, maxBubbleSize));
      i--;
    }

    // Init animation controller
    _controller = new AnimationController(
        duration: const Duration(seconds: 2000), vsync: this);
    _controller.addListener(() {
      updateBubblePosition();
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Stack(
        children:[
          Container(
            color: Colors.yellow,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(32),
                          bottomLeft: Radius.circular(32)
                      ),
                    ),
                    height: MediaQuery.of(context).size.height*2/3.1,
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("                     "),
                                Text("Home", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                                Row(
                                  children: [
                                    Icon(Icons.lightbulb_outline),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.share),
                                  ],
                                )
                              ],
                            ),
                            Image.asset("assets/dev.png"),
                            Container(padding: EdgeInsets.all(7),child: Text("   DevFests are community-led, deleveloper events hosted by GDG   chapters around the globe focused on community building & learning about Google's technologies. Each DevFest is inspired by and uniquely tailored to the needs of the developer community and region that hosts it", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 11),))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height/3.1,
                    padding: EdgeInsets.only(top: 22),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height/10,
                                width: MediaQuery.of(context).size.width/3.95,
                                child: ProgressButton(
                                  borderRadius: BorderRadius.all(Radius.circular(9),),
                                  onPressed: (AnimationController controller) async {
                                      controller.forward();
                                      await getDataSpeakers();
                                      await getDataTime();
                                      await  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>AgendaListWidget()));
                                    if (controller.isCompleted) {
                                      controller.reverse();
                                    } else {
                                      controller.forward();
                                    }
                                  },
                                  color: Colors.yellow,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.access_time, color: Colors.red,),
                                        Text('Agenda',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                               buildContainer(context, "Speakers", SpeakersScreen(), Icons.person, Colors.green, FontWeight.bold),
                              buildContainer(context, "Team", TeamListWidget(), Icons.people, Colors.deepPurple, FontWeight.bold),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height/15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              buildContainer(context, "Sponsors", SponsorsScreen(), Icons.attach_money, Colors.teal, FontWeight.normal),
                              buildContainer(context, "FAQ", TeamListWidget(), Icons.forum, Colors.brown, FontWeight.normal),
                              buildContainer(context, "Location", TeamListWidget(), Icons.location_on, Colors.blue, FontWeight.normal),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          CustomPaint(
          foregroundPainter:
              BubblePainter(bubbles: bubbles, controller: _controller),
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height),
        ),
    ]
      ),
    );
  }

buildContainer(BuildContext context, String text, Widget widget, IconData icon, Color colorIcon, FontWeight fontWeight)  {
    return Container(
                              height: MediaQuery.of(context).size.height/10,
                              width: MediaQuery.of(context).size.width/3.90,
                              child: ProgressButton(
                                borderRadius: BorderRadius.all(Radius.circular(9),),
                                onPressed: (AnimationController controller) async {
                                    controller.forward();
                                await  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>widget));
                                  if (controller.isCompleted) {
                                    controller.reverse();
                                  } else {
                                  }
                                },
                                color: Colors.yellow,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(icon, color: colorIcon,),
                                      Text(text,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: fontWeight
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
  }

  void updateBubblePosition() {
    bubbles.forEach((it) => it.updatePosition());
    setState(() {});
  }
}

class BubblePainter extends CustomPainter {
  List<Bubble> bubbles;
  AnimationController controller;

  BubblePainter({this.bubbles, this.controller});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    bubbles.forEach((it) => it.draw(canvas, canvasSize));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Bubble {
  Color colour;
  double direction;
  double speed;
  double radius;
  double x;
  double y;

  Bubble(Color colour, double maxBubbleSize) {
    this.colour = colour.withOpacity(Random().nextDouble());
    this.direction = Random().nextDouble() * 360;
    this.speed = 8;
    this.radius = Random().nextDouble() * maxBubbleSize;
    new Future.delayed(new Duration(seconds: 1), () async {
      this.speed=6;
    });
    new Future.delayed(new Duration(seconds: 2), () async {
      this.speed=1;
    });
  }

  draw(Canvas canvas, Size canvasSize) {
    Paint paint = new Paint()
      ..color = colour
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    randomlyChangeDirectionIfEdgeReached(canvasSize);

    canvas.drawCircle(Offset(x, y), radius, paint);
  }



  updatePosition() {
    if (x == null) {
      this.x = Random().nextDouble();
    }

    if (y == null) {
      this.y = Random().nextDouble();
    }
    var a = 180 - (direction + 90);
    direction > 0 && direction < 180
        ? x =x + speed * sin(direction) / sin(speed)
        : x =x- speed * sin(direction) / sin(speed);
    direction > 90 && direction < 270
        ? y=y+ speed * sin(a) / sin(speed)
        : y =y- speed * sin(a) / sin(speed);
  }

  randomlyChangeDirectionIfEdgeReached(Size canvasSize) {
    if (x > canvasSize.width || x < 0 || y > canvasSize.height || y < 0) {
      direction = Random().nextDouble() * 360;
    }
  }
}
