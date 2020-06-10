import 'dart:io';

import 'package:bongo_quiz/model/friend.dart';
import 'package:bongo_quiz/shared/intro_item.dart';
import 'package:flutter/material.dart';

class ChallengeReview extends StatelessWidget {
  final Map<String, dynamic> answers;
  final String screenshotPath;
  final Friend me;
  final Friend opponent;

  const ChallengeReview({
    @required this.answers,
    @required this.screenshotPath,
    @required this.me,
    @required this.opponent,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height - mediaQuery.padding.top;
    return Center(
      child: PageView.builder(
          itemCount: answers['me'].length,
          itemBuilder: (ctx, index) {
            final image =
                File("$screenshotPath/${answers['me'][index]['image']}");
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  (index + 1) == 7 ? "Final Round" : "Round ${index + 1}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          IntroItem(me),
                          SizedBox(height: 10),
                          Text(
                            "Score: ${answers['me'][index]['points']}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IntroItem(opponent),
                          SizedBox(height: 10),
                          Text(
                            "Score: ${answers['opponent'][index]['points']}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    // height: screenHeight * 0.7,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[900],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
