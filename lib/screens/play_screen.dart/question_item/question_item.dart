import 'dart:io';

import 'package:bongo_quiz/model/answer.dart';
import 'package:bongo_quiz/model/friend.dart';
import 'package:bongo_quiz/model/question.dart';
import 'package:bongo_quiz/screens/play_screen.dart/question_item/player_1_avatar.dart';
import 'package:bongo_quiz/screens/play_screen.dart/question_item/player_2_avatar.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class QuestionItem extends StatefulWidget {
  final Question question;
  final Function nextQns;
  final Friend me;
  final Friend opponent;
  final int round;
  final Function whisperAnswer;
  final List<dynamic> opponentAnswers, myAnswers;
  final String screenshotPath;
  QuestionItem({
    @required this.round,
    @required this.me,
    @required this.opponent,
    @required this.question,
    @required this.nextQns,
    @required this.whisperAnswer,
    @required this.opponentAnswers,
    @required this.myAnswers,
    @required this.screenshotPath,
  });
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
  bool showOpponentAns = false;
  bool timeout = false;
  var points = 0;
  ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    _controller = AnimationController(
        duration: Duration(seconds: questionDuration), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          timeout = true;
          _nextQuestion();
        }
      });
    _animation = Tween<double>(begin: 1, end: 0).animate(_controller);

//Delay the showing the round
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        opacity = 0.0;
      });
    });
    super.initState();
  }

  void _chooseAnswer(int id) {
    final currentTime = _controller.value;
    if (widget.round < 7) {
      if (currentTime <= 0.2) {
        points = 20;
      } else if (currentTime <= 0.4) {
        points = 19;
      } else if (currentTime <= 0.6) {
        points = 18;
      } else {
        points = 17;
      }
    } else {
      points = 30;
    }

    if (choosed != null || timeout) return;
    setState(() {
      choosed = id;
    });

    widget.whisperAnswer({
      'questionId': widget.question.id,
      'answerId': id,
      'points': widget.question.answers
              .firstWhere((answer) => answer.id == id)
              .correct
          ? points
          : 0,
      'image': '',
    });
  }

  void _nextQuestion() {
    setState(() {
      showOpponentAns = true;
    });
    String imageFile = "${widget.question.id}_screenshot.png";
    String path = "${widget.screenshotPath}/$imageFile";
    _screenshotController.capture(path: path).then((image) {
      // print("image captured");
    });
    Future.delayed(Duration(seconds: 3),
        () => widget.nextQns(widget.question.id, choosed, imageFile));
  }

  @override
  void dispose() {
    _controller.removeStatusListener((status) {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double imageSize = 150;
    // print(widget.opponentAnswers);
    return Stack(
      children: <Widget>[
        Screenshot(
          controller: _screenshotController,
          child: SizedBox.expand(
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
                          Player1Avatar(
                            animation: _animation.value,
                            me: widget.me,
                            myAnswers: widget.myAnswers,
                          ),
                          Player2Avatar(
                            animation: _animation.value,
                            opponent: widget.opponent,
                            opponentAnswers: widget.opponentAnswers,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.question.body,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                widget.question.image != null
                    ? Container(
                        child: Image.network(
                          widget.question.image,
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
                    children: widget.question.answers
                        .map((answer) => answerButton(answer: answer))
                        .toList(),
                  ),
                ),
              ],
            ),
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
                    widget.round == 7 ? "Final Round" : "Round ${widget.round}",
                    style: TextStyle(
                      color: Colors.green[700],
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
            onEnd: () {
              setState(() {
                visible = false;
              });
              _controller.forward();
            },
          ),
        ),
      ],
    );
  }

  Widget answerButton({Answer answer}) {
    Color textColor, buttonColor;
    final opponentAns = widget.opponentAnswers
            .where((element) =>
                (element['questionId'] == widget.question.id) &&
                (element['answerId'] == answer.id))
            .length >
        0;
    if ((choosed == answer.id || (opponentAns && showOpponentAns)) &&
        !answer.correct) {
      buttonColor = Colors.red;
      textColor = Colors.white;
    } else if (((choosed == answer.id || (opponentAns && showOpponentAns)) &&
            answer.correct) ||
        (answer.correct && showOpponentAns)) {
      buttonColor = Colors.green[700];
      textColor = Colors.white;
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(
          answer.body,
          style: TextStyle(
            color: textColor ?? Colors.black,
            fontSize: 17,
          ),
        ),
        color: buttonColor ?? Colors.grey[300],
        onPressed: () => _chooseAnswer(answer.id),
      ),
    );
  }
}
