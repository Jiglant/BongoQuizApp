import 'package:bongo_quiz/providers/home_provider.dart';
import 'package:bongo_quiz/providers/language_provider.dart';
import 'package:bongo_quiz/shared/topic_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteTopics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            Provider.of<HomeProvider>(context, listen: false).loadFavorites(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          }
          return Consumer<HomeProvider>(
            builder: (_, home, __) {
              if (home.favoriteTopics.length < 1) {
                return Container();
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
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
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
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                        color: Theme.of(context).primaryColor)),
                                child: Text(
                                  'More',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: home.favoriteTopics
                              .map((topic) => TopicItem(topic))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
