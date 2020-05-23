import 'package:bongo_quiz/screens/welcome/page_item_1.dart';
import 'package:bongo_quiz/screens/welcome/page_item_2.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static const route = "welcome-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: PageView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              PageItem1(
                asset: "assets/image/faster.png",
                title: "Fast and reliable connetion",
              ),
              PageItem2(
                asset: "assets/image/Challenging.png",
                title: "Time is Everything",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
