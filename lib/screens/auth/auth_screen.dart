import 'package:bongo_quiz/screens/auth/login.dart';
import 'package:bongo_quiz/screens/auth/register.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const route = "auth-screen";
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var showLogin = true;

  void _changeAuthForm() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.contain,
            image: AssetImage('assets/image/logo.png'),
          ),
        ),
        child: showLogin
            ? Register(
                changeForm: _changeAuthForm,
              )
            : Login(
                changeForm: _changeAuthForm,
              ),
      )),
    );
  }
}
