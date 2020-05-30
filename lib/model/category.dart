import 'package:bongo_quiz/model/topic.dart';
import 'package:flutter/material.dart';

class MyCategory {
  final int id;
  final String name;
  final List<Topic> topics;

  MyCategory({
    @required this.id,
    @required this.name,
    @required this.topics,
  });
}
