import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timer',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  double percent = 0.0;
  int counter = 0;
  int counter1 = 0;
  int inseconds = 0;
  final TextEditingController t1 = TextEditingController();
  Timer timer;
  void settime() {
    setState(() {
      counter = int.parse(t1.text);
      inseconds = counter;
      counter1 = 0;
    });
  }

  void start() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (counter1 < inseconds) {
          counter--;
          percent = (++counter1 / inseconds);
        } else {
          timer.cancel();
        }
      });
    });
  }

  void pause() {
    timer.cancel();
  }

  void resume() {
    start();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.pink, Colors.white],
        )),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 70.0),
              child: Text(
                "Timer",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            Expanded(
                child: CircularPercentIndicator(
              circularStrokeCap: CircularStrokeCap.round,
              percent: percent,
              animation: true,
              radius: 200,
              lineWidth: 15,
              progressColor: Colors.green,
              center: Text(
                '$counter',
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.red,
                ),
              ),
            )),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: 30.0)),
                          RaisedButton(
                            onPressed: start,
                            color: Colors.pinkAccent,
                            child: Text(
                              'START',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 20.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RaisedButton(
                                onPressed: resume,
                                color: Colors.pinkAccent,
                                child: Text(
                                  'RESUME',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 100)),
                              RaisedButton(
                                onPressed: pause,
                                color: Colors.pinkAccent,
                                child: Text(
                                  'PAUSE',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: 70.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 80,
                                width: 200,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                      hintText: 'Enter the Seconds',
                                      focusColor: Colors.pinkAccent),
                                  controller: t1,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 20)),
                              CircleAvatar(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.check,
                                  ),
                                  onPressed: settime,
                                ),
                                backgroundColor: Colors.pinkAccent,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
