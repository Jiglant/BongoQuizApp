import 'package:bongo_quiz/providers/home_provider.dart';
import 'package:bongo_quiz/providers/language_provider.dart';
import 'package:bongo_quiz/shared/topic_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteTopics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, home, __) {
        if (home.favoriteTopics.length < 1) {
          return Container();
        }
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(width: 10),
                    Consumer<LanguageProvider>(
                      builder: (_, language, __) => Text(
                        language.term('Favorites'),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      home.favoriteTopics.map((topic) => TopicItem(topic)).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
