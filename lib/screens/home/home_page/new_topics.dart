import 'package:bongo_quiz/providers/home_provider.dart';
import 'package:bongo_quiz/providers/language_provider.dart';
import 'package:bongo_quiz/shared/topic_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewTopics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
            Provider.of<HomeProvider>(context, listen: false).loadNewTopics(),
        builder: (_, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      }
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 10, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check_box_outline_blank,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(width: 10),
                    Consumer<LanguageProvider>(
                      builder: (_, language, child) => Text(
                        language.term('New Topics'),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
              Consumer<HomeProvider>(
                builder: (_, home, __) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    children: home.newTopics
                        .map((topic) => TopicItem(topic))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
