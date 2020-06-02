import 'package:bongo_quiz/model/friend.dart';
import 'package:bongo_quiz/screens/topic_detail_screen/topic_details_screen.dart';
import 'package:flutter/material.dart';

class FriendItem extends StatelessWidget {
  final Friend friend;
  FriendItem(this.friend);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      highlightColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[100]),
            borderRadius: BorderRadius.circular(10)),
        width: 60,
        child: Column(
          children: <Widget>[
            Container(
              child: friend.avatar.length > 0
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(friend.avatar),
                      maxRadius: 20,
                    )
                  : Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
            ),
            SizedBox(height: 3),
            Text(
              friend.name,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              maxLines: 2,
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
