import 'package:bongo_quiz/model/category.dart';
import 'package:bongo_quiz/providers/language_provider.dart';
import 'package:bongo_quiz/screens/home/topics_page/category_topics.dart';
import 'package:bongo_quiz/shared/topic_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final MyCategory category;
  CategoryItem(this.category);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  category.name,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontSize: 18),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                  child: Consumer<LanguageProvider>(
                    builder: (_, language, __) => Text(
                      language.term('Load More'),
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  onPressed: () {
                    var category = {
                      'id': this.category.id,
                      'name': this.category.name
                    };
                    Navigator.of(context)
                        .pushNamed(CategoryTopics.route, arguments: category);
                  },
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                direction: Axis.horizontal,
                children:
                    category.topics.map((topic) => TopicItem(topic)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
