import 'package:flutter/foundation.dart';

class Topic {
  final int id;
  final String name;
  final String description;
  final String imageUrl;

  const Topic({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.imageUrl,
  });
}
