import 'dart:convert';
import 'dart:io';

import 'package:bongo_quiz/resources.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  Future<dynamic> registerUser({
    @required String email,
    @required String username,
    @required String password,
  }) async {
    try {
      final response = await http.post(
        REGISTER_ROUTE,
        body: {
          'email': email,
          'username': username,
          'password': password,
        },
        headers: {HttpHeaders.acceptHeader: "application/json"},
      );
      final data = (json.decode(response.body)) as Map<String, dynamic>;
      // print(data);
      if (data.containsKey('success')) {
        final token = data['token'];
        final userId = data['user']['id'].toString();
        final username = data['user']['username'];
        final email = data['user']['email'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('_token', token);
        await prefs.setString('userId', userId);
        await prefs.setString('username', username);
        await prefs.setString('email', email);
      } else if (data.containsKey('error')) {
        throw data['error'] as Map<String, dynamic>;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> loginUser({
    @required String username,
    @required String password,
  }) async {
    try {
      final response = await http.post(
        LOGIN_ROUTE,
        body: {
          'username': username,
          'password': password,
        },
        headers: {HttpHeaders.acceptHeader: "application/json"},
      );
      final data = (json.decode(response.body)) as Map<String, dynamic>;
      // print(data);
      // return;
      if (data.containsKey('success')) {
        final token = data['token'];
        final userId = data['user']['id'].toString();
        final username = data['user']['username'];
        final email = data['user']['email'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('_token', token);
        await prefs.setString('userId', userId);
        await prefs.setString('username', username);
        await prefs.setString('email', email);
      } else if (data.containsKey('error') && data['error']=="Invalid Credentials") {
        throw("invalid");
      }
    } catch (e) {
      throw e;
    }
  }
}
