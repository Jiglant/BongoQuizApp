import 'package:bongo_quiz/model/friend.dart';
import 'package:flutter/material.dart';

class TopicDetails {
  final int id;
  final String name;
  final String imageUrl;
  final int followersCount;
  final int playerLevel;
  final bool isFollowing;
  final dynamic rankings;
  final List<Friend> friends;

  TopicDetails({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.followersCount,
    @required this.playerLevel,
    @required this.isFollowing,
    this.rankings,
    @required this.friends,
  });
}
