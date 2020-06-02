import 'package:bongo_quiz/providers/topic_details_provider.dart';
import 'package:bongo_quiz/screens/topic_detail_screen/action_buttons.dart';
import 'package:bongo_quiz/screens/topic_detail_screen/pic_and_level.dart';
import 'package:bongo_quiz/screens/topic_detail_screen/progress_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicDetailsScreen extends StatelessWidget {
  static const route = "topic_details";
  @override
  Widget build(BuildContext context) {
    final topicId = ModalRoute.of(context).settings.arguments as int;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: Provider.of<TopicDetailsProvider>(context, listen: false)
                .loadTopicDetails(topicId),
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
                          child: Text('Oops! Something went wrong'),
                        ),
                );
              } else {
                return Consumer<TopicDetailsProvider>(
                  builder: (_, provider, __) {
                    return Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Text(provider.details.name,
                              style: Theme.of(context).textTheme.headline5),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            PicAndLevel(provider),
                            Expanded(
                              child: ActionButtons(provider),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        ProgressRow(provider),
                      ],
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
