import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:handongsam/survey_inform.dart';

TimeOfDay selectedTime = TimeOfDay.now();
String time = "${selectedTime.hour}:${selectedTime.minute}";

int selectItem = 0;
String minute = "${selectItem}분 전";


class Alarm extends StatefulWidget{
  static const routeName = '/alarmScreen';
  @override
  AlarmState createState() => AlarmState();
}

class AlarmState extends State<Alarm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon : Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Center(
          child : const Text("맛알람 설정"),
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon : Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.pushNamed(context, SurveyInform.routeName);
                },
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: AlarmSetting(),
      ),
    );
  }
}

class AlarmSetting extends StatefulWidget{
  @override
  AlarmSettingState createState() => new AlarmSettingState();
}

class AlarmSettingState extends State<AlarmSetting>{
  bool _value1 = false;
  bool _value2 = false;
  void _onChanged1(bool value) => setState(() => _value1 = value);
  void _onChanged2(bool value) => setState(() => _value2 = value);

  @override
  Widget build(BuildContext context) {
    return ListView(
      itemExtent: 60.0,
      children: <Widget>[
        SetAlarm(context),
        SetAlarmTime(context),
        SetBeforeTime(context),
        SetRealarm(),
      ],
    );
  }

  ListTile SetAlarm(BuildContext context){
    return ListTile(
      leading:Text("알림", style:TextStyle(fontSize: 17.0)),
      title :Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Switch(value: _value1, onChanged: _onChanged1),
        ],
      ),
    );
  }

  ListTile SetAlarmTime(BuildContext context){
    return ListTile(
      leading:Text("복용시간", style:TextStyle(fontSize: 17.0)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              _selectTime(context);
            },
            padding: EdgeInsets.all(0.0),
            child : Text(time,style:TextStyle(fontSize: 17.0, color: Colors.blueAccent)),
          ),
        ],
      ),
    );
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now());
    if(picked!=null)
      setState(() {
        selectedTime = picked;
        time = "${selectedTime.hour}:${selectedTime.minute}";
      });
  }


  ListTile SetBeforeTime(BuildContext context){
    return ListTile(
      leading:Text("알람", style:TextStyle(fontSize: 17.0)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext builder) {
                    return Container(
                        height: MediaQuery.of(context).copyWith().size.height / 3,
                        child: _selectMinute(context)
                    );
                  }
              );
            },

            padding: EdgeInsets.all(0.0),
            child : Text(minute, style:TextStyle(fontSize: 17.0, color: Colors.blueAccent)),
          ),
        ],
      ),
    );
  }

  Widget _selectMinute(BuildContext context){
    var list = [1,10,15,20,25,30];
    return CupertinoPicker(
      itemExtent: 50.0,
      children: <Widget>[
        Text("5"),
        Text("10"),
        Text("15"),
        Text("20"),
        Text("25"),
        Text("30"),
      ],
      onSelectedItemChanged: (int value){
        setState(() {
          selectItem = list[value];
          minute = "${selectItem}분 전";
        });
      },
    );
  }


  ListTile SetRealarm() {
    return ListTile(
      leading: Text("다시알림", style:TextStyle(fontSize: 17.0)),
      title :Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Switch(value: _value2, onChanged: _onChanged2),
        ],
      ),
    );
  }

}