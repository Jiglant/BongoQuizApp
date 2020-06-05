import 'package:bongo_quiz/model/friend.dart';
import 'package:flutter/material.dart';

class Player1Avatar extends StatelessWidget {
  Player1Avatar(
      {@required this.animation, @required this.me, @required this.myAnswers});

  final double animation;
  final Friend me;
  final List<dynamic> myAnswers;

  int totalScore() {
    int score = 0;
    myAnswers.forEach((answer) {
      score += answer['points'];
    });
    return score;
  }

  @override
  Widget build(BuildContext context) {
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
              child: me.avatar.length > 0
                  ? CircleAvatar(
                      radius: 12.5,
                      backgroundImage: NetworkImage(me.avatar),
                      backgroundColor: Colors.transparent,
                    )
                  : const Icon(
                      Icons.person,
                      size: 25,
                      color: Colors.white,
                    ),
            ),
            SizedBox(height: 10),
            Text(
              me.name,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(width: 10),
        Column(
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
            SizedBox(
              width: timeoutContainerWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    totalScore().toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
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
            ),
          ],
        ),
      ],
    );
  }
}
