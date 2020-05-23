import 'package:bongo_quiz/providers/auth_provider.dart';
import 'package:bongo_quiz/providers/language_provider.dart';
import 'package:bongo_quiz/screens/home_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final Function changeForm;

  Register({@required this.changeForm});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var usernameChanged = false;
  var email, username, password;
  dynamic errors ={};
  FocusNode emailNode, usernameNode, passwordNode, confirmPasswordNode;
  final key = GlobalKey<FormState>();

  @override
  void initState() {
    emailNode = new FocusNode();
    usernameNode = new FocusNode();
    passwordNode = new FocusNode();
    confirmPasswordNode = new FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailNode.dispose();
    usernameNode.dispose();
    passwordNode.dispose();
    confirmPasswordNode.dispose();
    super.dispose();
  }

  void _validateForm() {

    if (key.currentState.validate()) {
      print("Valide data");
      Provider.of<AuthProvider>(context, listen: false)
          .registerUser(email: email, username: username, password: password)
          .then((_) {
        Navigator.of(context).pushReplacementNamed(HomePage.route);
      }).catchError((error) {
        setState(() {
          errors = error;
        });
      });
    }
  }

  Widget _hasError(String value) {
    if ((errors as Map<dynamic,dynamic>).containsKey(value)) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          errors[value][0].toString(),
          style: TextStyle(color: Colors.red, fontSize: 13),
        ),
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return TweenAnimationBuilder(
      duration: Duration(seconds: 1),
      tween: Tween<double>(begin: -1, end: 0),
      curve: Curves.fastOutSlowIn,
      builder: (ctx, double value, child) {
        return Transform(
          transform: Matrix4.translationValues(value * width, 0, 0),
          child: Consumer<LanguageProvider>(
            builder: (_, language, child) {
              return Center(
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
                      key: key,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Text(
                              language.term('Register'),
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            SizedBox(height: 40),
                            TextFormField(
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 8),
                                labelText: language.term('Email'),
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
                              focusNode: emailNode,
                              onChanged: (value) {
                                email = value;
                              },
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(usernameNode);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return language.term("Email is required");
                                }
                                if (!EmailValidator.validate(value)) {
                                  return language.term("Invalid email");
                                }
                                return null;
                              },
                            ),
                            _hasError('email'),
                            SizedBox(height: 15),
                            TextFormField(
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 8),
                                  labelText: language.term("Username"),
                                  labelStyle: TextStyle(
                                    color: Colors.orange,
                                  ),
                                  hintText: language.term("name"),
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
                              focusNode: usernameNode,
                              onChanged: (value) {
                                username = value;
                              },
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(passwordNode);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return language.term("Username is required");
                                }
                                if (value.length < 4) {
                                  return language.term(
                                      "Username must be at least 4 characters");
                                }
                                return null;
                              },
                            ),
                            _hasError('username'),
                            Visibility(
                              visible: false,
                              child: Text("Username Suggestion"),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 8),
                                labelText: language.term("Password"),
                                labelStyle: TextStyle(
                                  color: Colors.orange,
                                ),
                                hintText: language.term("Password"),
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
                                prefixIcon: Icon(Icons.lock_outline,
                                    color: Colors.orange),
                              ),
                              style: TextStyle(color: Colors.orange[800]),
                              obscureText: true,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.visiblePassword,
                              cursorColor: Colors.deepOrange,
                              cursorWidth: 1,
                              focusNode: passwordNode,
                              onChanged: (value) {
                                password = value;
                              },
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(confirmPasswordNode);
                              },
                              validator: (value) {
                                if (value.length < 8) {
                                  return language.term("Password too short");
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 8),
                                labelText: language.term("Confirm"),
                                labelStyle: TextStyle(
                                  color: Colors.orange,
                                ),
                                hintText: language.term("Confirm password"),
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
                                prefixIcon: Icon(Icons.lock_outline,
                                    color: Colors.orange),
                              ),
                              style: TextStyle(color: Colors.orange[800]),
                              obscureText: true,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.visiblePassword,
                              cursorColor: Colors.deepOrange,
                              cursorWidth: 1,
                              focusNode: confirmPasswordNode,
                              validator: (value) {
                                if (value != password) {
                                  return "Password must match";
                                }
                                return null;
                              },
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
                                language.term("Register"),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              onPressed: _validateForm,
                            ),
                            SizedBox(height: 15),
                            FlatButton(
                              splashColor: Colors.blue[200],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                language.term("Log In"),
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
              );
            },
          ),
        );
      },
    );
  }
}
