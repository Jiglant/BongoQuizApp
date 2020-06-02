import 'dart:convert';
import 'dart:io';

import 'package:bongo_quiz/resources.dart';
import 'package:flutter/foundation.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserChannelProvider with ChangeNotifier {
  Echo echo;
  String token;
  String userId;
  String status;

  UserChannelProvider(bool load) {
    if (load) {
      this.init();
    }
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('_token') ?? "";
    userId = prefs.getString('userId') ?? null;
    // print(userId);
    // print(token);

    echo = new Echo({
      'broadcaster': 'socket.io',
      'client': IO.io,
      'host': LARAVEL_ECHO_HOST,
      'auth': {
        'headers': {'Authorization': 'Bearer $token'}
      }
    });
    echo.private('user.$userId').listen('.opponent.found', (data) {
      print(data);
      //TODO receive competition data for starting a challenge
    });
  }

  Future<dynamic> searchOpponent(int topicId) async {
    try {
      final result = await executeUrl("$SEARCH_OPPONENT_ROUTE$topicId");
      print(result);
      if (result.containsKey('message') &&
          result['message'] == 'Unauthenticated.') {
        throw ('Unauthenticated');
      } else if (result.containsKey('success')) {
        status = result['success'];
        notifyListeners();
      } else {
        throw ('error');
      }
    } catch (error) {
      throw (error);
    }
  }

  Future<Map<String, dynamic>> executeUrl(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final token = prefs.getString('_token') ?? '';
    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    return json.decode(response.body) as Map<String, dynamic>;
  }
}
