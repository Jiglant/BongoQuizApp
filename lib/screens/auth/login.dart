import 'package:bongo_quiz/providers/auth_provider.dart';
import 'package:bongo_quiz/providers/language_provider.dart';
import 'package:bongo_quiz/providers/user_channel_provider.dart';
import 'package:bongo_quiz/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final Function changeForm;

  const Login({@required this.changeForm});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var username, password;
  dynamic errors = {};
  FocusNode usernameNode, passwordNode;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    usernameNode = new FocusNode();
    passwordNode = new FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    usernameNode.dispose();
    passwordNode.dispose();
    super.dispose();
  }

  void _validateForm() {
    if (formKey.currentState.validate()) {
      Provider.of<AuthProvider>(context, listen: false)
          .loginUser(username: username, password: password)
          .then((_) {
        Provider.of<UserChannelProvider>(context, listen: false).init();
        Navigator.of(context).pushReplacementNamed(HomePage.route);
      }).catchError((error) {
        print(error);
        setState(() {
          if (error == "invalid") {
            errors = {
              'invalid': Provider.of<LanguageProvider>(context, listen: false)
                  .term("Invalid credentials")
            };
          } else {
            errors = {
              'invalid': Provider.of<LanguageProvider>(context, listen: false)
                  .term('Something went wrong')
            };
          }
        });
      });
    }
  }

  Widget _hasError(String value) {
    if ((errors as Map<dynamic, dynamic>).containsKey(value)) {
      return Padding(
        padding: const EdgeInsets.all(9.0),
        child: Text(
          errors[value].toString(),
          style: TextStyle(color: Colors.red, fontSize: 14),
        ),
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 1, end: 0),
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      builder: (_, value, child) {
        return Transform(
          transform: Matrix4.translationValues(value * width, 0, 0),
          child: Consumer<LanguageProvider>(
            builder: (_, language, child) {
              return Center(
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
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Text(
                              language.term("Log In"),
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            SizedBox(height: 40),
                            _hasError('invalid'),
                            TextFormField(
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 8),
                                labelText: language.term("Username or Email"),
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
                              ),
                              style: TextStyle(color: Colors.orange[800]),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.deepOrange,
                              focusNode: usernameNode,
                              cursorWidth: 1,
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
                                return null;
                              },
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
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Password is required";
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
                                language.term("Log In"),
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
                                language.term("New User"),
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
