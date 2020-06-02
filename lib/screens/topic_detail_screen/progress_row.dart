import 'package:bongo_quiz/providers/topic_details_provider.dart';
import 'package:flutter/material.dart';

class ProgressRow extends StatelessWidget {
  final TopicDetailsProvider provider;
  ProgressRow(this.provider);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              width: 90,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "20%",
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                  ),
                ),
              ),
            ),
            Text(
              "10 win",
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: Colors.grey,
                    fontSize: 17,
                  ),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              width: 90,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "10%",
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                  ),
                ),
              ),
            ),
            Text(
              "5 draw",
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: Colors.grey,
                    fontSize: 17,
                  ),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              width: 90,
              decoration: BoxDecoration(
                color: Colors.deepOrange[400],
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "70%",
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                  ),
                ),
              ),
            ),
            Text(
              "35 lost",
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: Colors.grey,
                    fontSize: 17,
                  ),
            )
          ],
        ),
      ],
    );
  }
}
