import 'package:bongo_quiz/providers/topics_provider.dart';
import 'package:bongo_quiz/shared/topic_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryTopics extends StatefulWidget {
  static const route = "cateory_topics";
  @override
  _CategoryTopicsState createState() => _CategoryTopicsState();
}

class _CategoryTopicsState extends State<CategoryTopics> {
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController()
      ..addListener(() {
        if(_controller.position.extentAfter<270){
          Provider.of<TopicsProvider>(context,listen: false).loadMoreCateoryTopics();
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final category =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(category['name']),
      ),
      body: FutureBuilder(
        future: Provider.of<TopicsProvider>(context, listen: false)
            .loadCateoryTopics(category['id']),
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
              builder: (_, provider, __) {
                return GridView.builder(
                  controller: _controller,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 80,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: provider.categoryTopics.length,
                  itemBuilder: (_, index) {
                    return TopicItem(provider.categoryTopics[index]);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
