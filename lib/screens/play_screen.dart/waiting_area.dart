import 'package:bongo_quiz/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class WaitingArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SpinKitRotatingPlain(
          color: Theme.of(context).primaryColor,
          duration: Duration(milliseconds: 2000),
          size: 70,
        ),
        SizedBox(height: 30),
        Consumer<LanguageProvider>(
          builder: (_, language, __) => Text(
            'Waiting for Opponent',
            style: Theme.of(context).textTheme.headline5.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
          ),
        ),
      ],
    );
  }
}
