import 'package:bongo_quiz/model/friend.dart';
import 'package:flutter/material.dart';

class Player2Avatar extends StatelessWidget {
  const Player2Avatar({
    @required this.animation,
    @required this.opponent,
    @required this.opponentAnswers,
  });

  final double animation;
  final Friend opponent;
  final List<dynamic> opponentAnswers;
  int totalScore() {
    int score = 0;
    opponentAnswers.forEach((answer) {
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
            SizedBox(
              width: timeoutContainerWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
                  Text(
                    totalScore().toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
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
              child: opponent.avatar.length > 0
                  ? CircleAvatar(
                      radius: 12.5,
                      backgroundImage: NetworkImage(opponent.avatar),
                      backgroundColor: Colors.transparent,
                    )
                  : Icon(
                      Icons.person,
                      size: 25,
                      color: Colors.white,
                    ),
            ),
            SizedBox(height: 10),
            Text(
              opponent.name,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
