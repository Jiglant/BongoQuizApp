import 'package:bongo_quiz/screens/home/favorite.dart';
import 'package:bongo_quiz/screens/home/new_topics.dart';
import 'package:bongo_quiz/shared/bottom_nav.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const route = "home-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {},
        ),
        title: Text('BongoQuiz'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FavoriteTopics(),
            NewTopics(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(255, 99, 71, 1),
        child: Icon(Icons.home, color: Colors.white, size: 30),
        onPressed: () {},
      ),
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}
