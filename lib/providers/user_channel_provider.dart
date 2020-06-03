import 'dart:convert';
import 'dart:io';

import 'package:bongo_quiz/model/answer.dart';
import 'package:bongo_quiz/model/challenge.dart';
import 'package:bongo_quiz/model/friend.dart';
import 'package:bongo_quiz/model/question.dart';
import 'package:bongo_quiz/model/topic.dart';
import 'package:bongo_quiz/resources.dart';
import 'package:flutter/foundation.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserChannelProvider with ChangeNotifier {
  Echo _echo;
  dynamic userPrivateChannel;

  String token;
  String userId;
  String status;
  Challenge _challenge;
  int currentTopicID;

  UserChannelProvider(bool load) {
    if (load) {
      this.init();
    }
  }

  Echo get echo {
    return _echo;
  }

  Challenge get challenge {
    return _challenge;
  }

  void setCurrentTopicId(int topicId) {
    this.currentTopicID = topicId;
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('_token') ?? "";
    userId = prefs.getString('userId') ?? null;

    _echo = new Echo({
      'broadcaster': 'socket.io',
      'client': IO.io,
      'host': LARAVEL_ECHO_HOST,
      'auth': {
        'headers': {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }
      }
    });

    userPrivateChannel = _echo.private('user.$userId');
  }

  Future<dynamic> searchOpponent(int topicId) async {
    try {
      final result = await executeUrl("$SEARCH_OPPONENT_ROUTE$topicId");
      // print(result);
      if (result.containsKey('message') &&
          result['message'] == 'Unauthenticated.') {
        throw ('Unauthenticated');
      } else if (result.containsKey('success') &&
          result['success'] == 'found') {
        status = result['success'];
        _challenge = convertToChallenge(result['challenge']);
        notifyListeners();
      } else {
        throw ('error');
      }
    } catch (error) {
      throw (error);
    }
  }

  Challenge convertToChallenge(dynamic data) {
    final players = data['players'] as List<dynamic>;
    Friend me, opponent;
    players.forEach((player) {
      if (player['id'].toString() == this.userId) {
        me = Friend(
          id: player['id'],
          name: player['name'],
          avatar: player['avatar'],
        );
      } else {
        opponent = Friend(
          id: player['id'],
          name: player['name'],
          avatar: player['avatar'],
        );
      }
    });
    final item = Challenge(
      id: data['id'],
      me: me,
      opponent: opponent,
      topic: Topic(
        id: data['topic']['id'],
        name: data['topic']['name'],
        description: data['topic']['description'],
        imageUrl: data['topic']['imageUrl'],
      ),
      questions: (data['questions'] as List<dynamic>)
          .map((question) => Question(
                id: question['id'],
                body: question['body'],
                image: question['image'],
                answers: (question['answers'] as List<dynamic>)
                    .map((answer) => Answer(
                          id: answer['id'],
                          body: answer['body'],
                          correct: answer['value'],
                        ))
                    .toList(),
              ))
          .toList(),
    );
    return item;
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
