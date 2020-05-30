import 'package:bongo_quiz/model/topic.dart';
import 'package:bongo_quiz/screens/topic_detail_screen/topic_details_screen.dart';
import 'package:flutter/material.dart';

class TopicItem extends StatelessWidget {
  final Topic topic;
  TopicItem(this.topic);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      highlightColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: 60,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/image/logo.png",
                  image: topic.imageUrl,
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 100),
                  height: 55,
                  width: 55,
                ),
              ),
            ),
            SizedBox(height: 3),
            Text(
              topic.name,
              style: TextStyle(
                  color: Colors.grey[700], fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              maxLines: 2,
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(TopicDetailsScreen.route,arguments: topic.id);
      },
    );
  }
}
