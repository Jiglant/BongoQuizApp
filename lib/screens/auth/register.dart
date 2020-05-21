import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Register extends StatefulWidget {
  final Function changeForm;

  Register({@required this.changeForm});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var usernameChanged = false;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return TweenAnimationBuilder(
      duration: Duration(seconds: 1),
      tween: Tween<double>(begin: -1, end: 0),
      curve: Curves.fastLinearToSlowEaseIn,
      builder: (ctx, double value, child) {
        return Transform(
          transform: Matrix4.translationValues(value * width, 0, 0),
          child: Center(
            child: Container(
              height: 490,
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
                          "Register",
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
                            labelText: "Email",
                            labelStyle: TextStyle(
                              color: Colors.orange,
                            ),
                            hintText: "email@email.com",
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
                            prefixIcon: Icon(Icons.alternate_email,
                                color: Colors.orange),
                          ),
                          style: TextStyle(color: Colors.orange[800]),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.deepOrange,
                          cursorWidth: 1,
                        ),
                        SizedBox(height: 15),
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
                              suffix: Container(
                                width: 30,
                                margin: EdgeInsets.only(right: 10),
                                child: usernameChanged
                                    ? SpinKitCircle(
                                        color: Colors.green,
                                        size: 20,
                                      )
                                    : Container(),
                              )),
                          style: TextStyle(color: Colors.orange[800]),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.deepOrange,
                          cursorWidth: 1,
                        ),
                        Visibility(
                          visible: false,
                          child: Text("Username Suggestion"),
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
                        TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                            labelText: "Confirm",
                            labelStyle: TextStyle(
                              color: Colors.orange,
                            ),
                            hintText: "confirm password",
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
                            "Register",
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
                            "Log In",
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
