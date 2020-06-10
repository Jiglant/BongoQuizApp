import 'package:bongo_quiz/model/friend.dart';
import 'package:flutter/material.dart';

class IntroItem extends StatelessWidget {
  final Friend friend;
  final itemRadius = 80.0;
  IntroItem(this.friend);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemRadius,
      width: itemRadius,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(itemRadius)),
        border: Border.all(color: Colors.grey[100],width: 2),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            friend.avatar.length > 0
                ? CircleAvatar(
                    backgroundImage: NetworkImage(friend.avatar),
                    maxRadius: 30,
                  )
                : Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.white,
                  ),
            SizedBox(height: 3),
            Text(
              friend.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
