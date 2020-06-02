import 'package:bongo_quiz/screens/home/home_page/favorite.dart';
import 'package:bongo_quiz/screens/home/home_page/new_topics.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FavoriteTopics(),
                NewTopics(),
              ],
            ),
          );
  }
}