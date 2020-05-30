import 'package:bongo_quiz/providers/language_provider.dart';
import 'package:bongo_quiz/providers/topics_provider.dart';
import 'package:bongo_quiz/screens/home/topics_page/category_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Consumer<LanguageProvider>(
          builder: (_, language, __) => Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              language.term('Topics'),
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: Provider.of<TopicsProvider>(context, listen: false)
                .loadCategories(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: snapshot.error.toString() == 'connection_error'
                      ? Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.network_check,
                              size: 50,
                            ),
                            SizedBox(width: 10),
                            Text("Connection Error",
                                style: Theme.of(context).textTheme.subtitle1),
                          ],
                        )
                      : Container(
                          child: Text('Oops! SOmething went wrong'),
                        ),
                );
              } else {
                return Consumer<TopicsProvider>(
                  builder: (_, categories, __) {
                    return ListView.builder(
                      itemCount: categories.categories.length,
                      itemBuilder: (_, index) {
                        if (categories.categories[index].topics.length < 1) {
                          return Container();
                        }
                        return CategoryItem(categories.categories[index]);
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
