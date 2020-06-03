import 'dart:async';

import 'package:bongo_quiz/model/friend.dart';
import 'package:bongo_quiz/shared/intro_item.dart';
import 'package:flutter/material.dart';

class IntroArea extends StatefulWidget {
  final Friend me, opponent;
  final Function startGame;

  const IntroArea({this.me, this.opponent, this.startGame});

  @override
  _IntroAreaState createState() => _IntroAreaState();
}

class _IntroAreaState extends State<IntroArea> {
  Timer _timer;

  @override
  void initState() {
    _timer = new Timer(Duration(seconds: 3), widget.startGame);
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: -1, end: 0),
      duration: Duration(milliseconds: 500),
      builder: (_, value, child) {
        return Center(
          child: Container(
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Transform(
                    transform:
                        Matrix4.translationValues(0, screenHeight * value, 0),
                    child: IntroItem(widget.me),
                  ),
                  Text(
                    "VS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        0, -(screenHeight) * value, 0),
                    child: IntroItem(widget.opponent),
                  ),
                ],
              )),
        );
      },
    );
  }
}
