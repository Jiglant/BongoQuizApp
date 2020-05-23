import 'package:bongo_quiz/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';

class PageItem2 extends StatelessWidget {
  final String asset;
  final String title;
  const PageItem2({this.asset, this.title});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 200),
      duration: Duration(milliseconds: 300),
      builder: (_, value, child) {
        return Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: value,
                    child: Opacity(
                      opacity: value / 200,
                      child: Image.asset(
                        asset,
                        fit: BoxFit.cover,
                      ),
                    ),
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
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.all(20),
                child: FlatButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "Start >>",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AuthScreen.route);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
