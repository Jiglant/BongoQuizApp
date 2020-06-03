import 'package:bongo_quiz/model/answer.dart';
import 'package:flutter/foundation.dart';

class Question {
  final int id;
  final String body;
  final String image;
  final List<Answer> answers;

  Question({
    @required this.id,
    @required this.body,
    @required this.image,
    @required this.answers,
  });
}
