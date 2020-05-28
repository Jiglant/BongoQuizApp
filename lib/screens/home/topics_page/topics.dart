import 'package:bongo_quiz/providers/home_provider.dart';
import 'package:bongo_quiz/providers/language_provider.dart';
import 'package:bongo_quiz/shared/topic_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicsPage extends StatefulWidget {
  @override
  _TopicsPageState createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController()
      ..addListener(() {
        print(_controller.position.extentAfter);
        if (_controller.position.extentAfter < 270) {
          Provider.of<HomeProvider>(context, listen: false).loadMoreTopics();
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
          child: Consumer<HomeProvider>(
            builder: (_, home, _child) => GridView.builder(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 85,
                  childAspectRatio: 1,
                  mainAxisSpacing: 5,
                ),
                itemCount: home.topics.length,
                itemBuilder: (_, index) => TopicItem(home.topics[index])),
          ),
        ),
      ],
    );
  }
}
