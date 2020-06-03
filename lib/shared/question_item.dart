import 'package:bongo_quiz/model/answer.dart';
import 'package:bongo_quiz/model/question.dart';
import 'package:flutter/material.dart';

class QuestionItem extends StatefulWidget {
  final Question question;
  QuestionItem({this.question});
  @override
  _QuestionItemState createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem>
    with TickerProviderStateMixin {
  final questionDuration = 7;
  AnimationController _controller;
  Animation<double> _animation;
  double opacity = 1;
  bool visible = true;
  int choosed;

  @override
  void initState() {
    _controller = AnimationController(
        duration: Duration(seconds: questionDuration), vsync: this);
    _animation = Tween<double>(begin: 1, end: 0).animate(_controller);

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        opacity = 0.0;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double imageSize = 150;
    return Stack(
      children: <Widget>[
        SizedBox.expand(
          child: Column(
            children: <Widget>[
              AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        player1Avatar(animation: _animation.value),
                        player2Avatar(animation: _animation.value),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "The best movie actor 2012, Hollywood actors akjhkfa akjfha faksj hiwuf fakjahf a vakjhf kjhiuf kjhay kjhafa ;kajsfh ;kasjhfh",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              "234".length > 0
                  ? Container(
                      child: Image.network(
                        "http://192.168.43.136:8000/image/1",
                        fit: BoxFit.cover,
                        height: imageSize,
                        width: imageSize,
                      ),
                    )
                  : Container(),
              SizedBox(height: 20),
              // Spacer(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    answerButton(id: 1, correct: true),
                    answerButton(id: 2, correct: false),
                    answerButton(id: 3, correct: false),
                    answerButton(id: 4, correct: false),
                  ],
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: visible,
          child: AnimatedOpacity(
            opacity: opacity,
            duration: Duration(milliseconds: 500),
            child: Container(
              color: Colors.black,
              child: SizedBox.expand(
                child: Center(
                  child: Text(
                    "Round 1",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            onEnd: () {
              _controller.forward();
              setState(() {
                visible = false;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget player1Avatar({double animation}) {
    final timeoutContainerWidth = 80.0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              child: Icon(
                Icons.person,
                size: 25,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              120.toString(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              height: 7,
              width: timeoutContainerWidth,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              child: FractionallySizedBox(
                widthFactor: animation,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            SizedBox(height: 10),
            CircleAvatar(
              radius: 13,
              backgroundColor: Colors.green,
              child: Text(
                40.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget player2Avatar({double animation}) {
    final timeoutContainerWidth = 80.0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 7,
              width: timeoutContainerWidth,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              child: FractionallySizedBox(
                widthFactor: animation,
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            SizedBox(height: 10),
            CircleAvatar(
              radius: 13,
              backgroundColor: Colors.green,
              child: Text(
                40.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 10),
        Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              child: Icon(
                Icons.person,
                size: 25,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              120.toString(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget answerButton({Answer answer, int id, bool correct}) {
    Color textColor, buttonColor;
    if (choosed == id && !correct) {
      buttonColor = Colors.red;
      textColor = Colors.white;
    } else if (choosed == id && correct) {
      buttonColor = Colors.green[700];
      textColor = Colors.white;
    } else {
      buttonColor = Colors.grey[300];
      textColor = Colors.black;
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          "Answer",
          style: TextStyle(
            color: textColor,
            fontSize: 17,
          ),
        ),
        color: buttonColor,
        onPressed: () {
          setState(() {
            choosed = id;
          });
        },
      ),
    );
  }
}
