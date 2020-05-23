import 'package:flutter/material.dart';

class PageItem1 extends StatelessWidget {
  final String asset;
  final String title;
  const PageItem1({this.asset, this.title});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TweenAnimationBuilder(
          tween: Tween<double>(begin: -5, end: 0),
          duration: Duration(milliseconds: 300),
          builder: (_, value, child) {
            return Transform(
              transform: Matrix4.translationValues(value * width, 0, 0),
              child: Container(
                height: 200,
                child: Image.asset(
                  asset,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        SizedBox(height: 20),
        Text(
          title,
          style: Theme.of(context).textTheme.headline4.copyWith(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w400,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
