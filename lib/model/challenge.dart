import 'package:bongo_quiz/model/friend.dart';
import 'package:bongo_quiz/model/question.dart';
import 'package:bongo_quiz/model/topic.dart';
import 'package:flutter/foundation.dart';

class Challenge {
  final int id;
  final Friend me;
  final Friend opponent;
  final Topic topic;
  final List<Question> questions;

  Challenge({
    @required this.id,
    @required this.me,
    @required this.opponent,
    @required this.topic,
    @required this.questions,
  });
}
