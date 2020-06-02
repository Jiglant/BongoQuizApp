import 'package:bongo_quiz/providers/topic_details_provider.dart';
import 'package:flutter/material.dart';

class PicAndLevel extends StatelessWidget {
  final TopicDetailsProvider provider;

  PicAndLevel(this.provider);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double levelBoxHeight = 12;
    return Container(
      width: width * 0.5,
      margin: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  blurRadius: 7,
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                provider.details.imageUrl,
                fit: BoxFit.cover,
                height: 150,
                width: 150,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Text(
                'Level',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Theme.of(context).accentColor),
              ),
              SizedBox(width: 10),
              Text(
                provider.currentLevel.toString(),
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
            width: 150,
            height: levelBoxHeight,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: provider.currentLevelPercent,
              child: Container(
                width: 150,
                height: levelBoxHeight,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
