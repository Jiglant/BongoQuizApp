import 'package:bongo_quiz/screens/home/topic_item.dart';
import 'package:flutter/material.dart';

class NewTopics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.check_box_outline_blank,color: Theme.of(context).accentColor,),
                Text(
                  'New Topics',
                  style:
                      Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 17),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              children: <Widget>[
                TopicItem(),
                TopicItem(),
                TopicItem(),
                TopicItem(),
                TopicItem(),
                TopicItem(),
                TopicItem(),
                TopicItem(),
                TopicItem(),
                TopicItem(),
                TopicItem(),
                TopicItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
