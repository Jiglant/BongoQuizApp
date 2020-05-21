import 'dart:math';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final Function changeForm;

  const Login({@required this.changeForm});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 1, end: 0),
      duration: Duration(seconds: 1),
      curve: Curves.fastLinearToSlowEaseIn,
      builder: (_, value, child) {
        return Transform(
          transform: Matrix4.translationValues(value * width, 0, 0),
          child: Center(
            child: Container(
              height: 400,
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Center(
                child: Form(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 40),
                        TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                            labelText: "Username",
                            labelStyle: TextStyle(
                              color: Colors.orange,
                            ),
                            hintText: "name",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                            prefixIcon: Icon(Icons.person_outline,
                                color: Colors.orange),
                          ),
                          style: TextStyle(color: Colors.orange[800]),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.deepOrange,
                          cursorWidth: 1,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                            labelText: "Password",
                            labelStyle: TextStyle(
                              color: Colors.orange,
                            ),
                            hintText: "password",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                            prefixIcon:
                                Icon(Icons.lock_outline, color: Colors.orange),
                          ),
                          style: TextStyle(color: Colors.orange[800]),
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: Colors.deepOrange,
                          cursorWidth: 1,
                        ),
                        SizedBox(height: 15),
                        RaisedButton(
                          color: Colors.orange,
                          splashColor: Colors.orangeAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 60, vertical: 13),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          onPressed: () {},
                        ),
                        SizedBox(height: 15),
                        FlatButton(
                          splashColor: Colors.blue[200],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            "New user?",
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: widget.changeForm,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
