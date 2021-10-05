import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _TouchApp createState() => _TouchApp();
}

class _TouchApp extends State<MyApp> {
  int number = 5;
  Color? heartcolor = Colors.red[500];
  int life = 5;
  IconData icon = Icons.favorite;
  int score = 0;
  int tapping = 0;
  int _counter = 10;
  Timer? _timer;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    _counter = 10;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          if (tapping >= 10) {
            _counter = 10;
            tapping = 0;
          } else {
            if (life > 1) {
              life--;
              _counter = 10;
            } else {
              life = 5;
              _stopTimer();
            }
          }
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  Color? changeState(int lifeactive) {
    if (life >= lifeactive) {
      heartcolor = Colors.red[500];
    } else {
      heartcolor = null;
    }
    return heartcolor;
  }

  IconData changeIcon(int lifeactive) {
    if (life >= lifeactive) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }
    return icon;
  }

  void startGame() {
    setState(() {
      tapping++;
      if (tapping == 10) {
        score++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('TapTap'),
        ),
        body: Container(
          margin: EdgeInsets.all(30.0),
          decoration:
              BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You Scored: ' + score.toString() + ' Point',
                style: TextStyle(fontSize: 40, color: Colors.blue[400]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    changeIcon(1),
                    size: 70,
                    color: changeState(1),
                  ),
                  Icon(
                    changeIcon(2),
                    size: 70,
                    color: changeState(2),
                  ),
                  Icon(
                    changeIcon(3),
                    size: 70,
                    color: changeState(3),
                  ),
                  Icon(
                    changeIcon(4),
                    size: 70,
                    color: changeState(4),
                  ),
                  Icon(
                    changeIcon(5),
                    size: 70,
                    color: changeState(5),
                  ),
                ],
              ),
              Text(
                'Time: ' + _counter.toString(),
                style: TextStyle(fontSize: 25, color: Colors.blue[900]),
              ),
              Text(
                'Life Left: ' + life.toString(),
                style: TextStyle(fontSize: 25, color: Colors.purple[900]),
              ),
              Text(
                'You Have Tap: ' +
                    tapping.toString() +
                    ' Times In Just 10 Seconds',
                style: TextStyle(fontSize: 30, color: Colors.pinkAccent[700]),
              ),
              ElevatedButton(
                onPressed: startGame,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(30),
                  primary: Colors.limeAccent[400],
                  onPrimary: Colors.black12,
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 100.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
