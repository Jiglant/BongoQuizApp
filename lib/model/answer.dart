import 'package:flutter/foundation.dart';

class Answer {
  final int id;
  final String body;
  final bool correct;

  Answer({
    @required this.id,
    @required this.body,
    @required this.correct,
  });
}
