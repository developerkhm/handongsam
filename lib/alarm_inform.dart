import 'package:flutter/material.dart';

import 'alarm.dart';
class AlarmInform extends StatefulWidget{
  static const routeName = '/alarmInformScreen';
  @override
  AlarmInformState createState() => AlarmInformState();
}

class AlarmInformState extends State<AlarmInform> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon : Icon(Icons.arrow_back_ios, color: Colors.black54, size: 18.0,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon : Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 18.0,),
                onPressed: () {
                  Navigator.pushNamed(context, Alarm.routeName, arguments:AlarmArguments(" "));
                },
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: MakeDescription(),
      ),
    );
  }

  Widget MakeDescription(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
            Icons.alarm,
            size:50.0,
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          child : Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "맛알람",
                    style: TextStyle(color: Colors.indigo[700], fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text("은", style: TextStyle(fontSize: 17),),
                ],
              ),
              Text("유산균 섭취시간을 알려드립니다.", style: TextStyle(fontSize: 17),),
            ],
          ),
        ),
        Container(
          child : Column(
            children: <Widget>[
              Text("유산균은 일정한 간격으로", style: TextStyle(fontSize: 17),),
              Text("먹었을 때 가장 큰 효과를", style: TextStyle(fontSize: 17),),
              Text("볼 수 있습니다.", style: TextStyle(fontSize: 17),),
            ],
          ),
        ),
      ],
    );
  }
}