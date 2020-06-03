import 'dart:convert';

import 'package:bongo_quiz/model/answer.dart';
import 'package:bongo_quiz/model/challenge.dart';
import 'package:bongo_quiz/model/friend.dart';
import 'package:bongo_quiz/model/question.dart';
import 'package:bongo_quiz/model/topic.dart';
import 'package:bongo_quiz/providers/user_channel_provider.dart';
import 'package:bongo_quiz/resources.dart';
import 'package:bongo_quiz/screens/play_screen.dart/intro_area.dart';
import 'package:bongo_quiz/screens/play_screen.dart/waiting_area.dart';
import 'package:bongo_quiz/shared/question_item.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:laravel_echo/laravel_echo.dart';
import 'package:provider/provider.dart';

class PlayScreen extends StatefulWidget {
  static const route = "play-screen";

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  Challenge _challenge;
  Echo _echo;
  UserChannelProvider provider;
  var whisperChannel;
  bool showIntro = false;
  bool resume = false;
  bool start = false;

  List<dynamic> _onlinePlayers = [];

  @override
  void initState() {
    // print('init');
    provider = Provider.of<UserChannelProvider>(context, listen: false);
    _echo = new Echo({
      'broadcaster': 'socket.io',
      'client': IO.io,
      'host': LARAVEL_ECHO_HOST,
      'auth': {
        'headers': {
          'Authorization': 'Bearer ${provider.token}',
          'Accept': 'application/json',
        }
      }
    });
    listen();
    provider.searchOpponent(provider.currentTopicID).then((value) {
      if (provider.status == 'found') {
        print('from api');
        _challenge = provider.challenge;
        listenForChallenge();
      }
    });
    super.initState();
  }

  void listen() {
    _echo.private('user.${provider.userId}').listen('.opponent.found', (data) {
      print('from socket');
      _challenge = provider.convertToChallenge(data);
      listenForChallenge();
    });
  }

  void listenForChallenge() {
    _echo.join('challenge.${_challenge.id}').here((users) {
      final players = users.toList();
      (players as List<dynamic>).forEach((player) {
        if (!_onlinePlayers.contains(player)) {
          _onlinePlayers.add(player);
        }
      });
      print("Online Players $_onlinePlayers");
      if (_onlinePlayers.length > 1) {
        setState(() {
          showIntro = true;
        });
      }
    }).joining((user) {
      print("jouning $user");
      if (!_onlinePlayers.contains(user)) {
        _onlinePlayers.add(user);
        if (_onlinePlayers.length > 1) {
          setState(() {
            showIntro = true;
          });
        }
      }
      print("Online Players $_onlinePlayers");
    }).leaving((user) {
      print("Leaving $user");
      if (!_onlinePlayers.contains(user)) {
        _onlinePlayers.removeWhere((player) => player['id'] == user['id']);
        if (_onlinePlayers.length < 2) {
          setState(() {
            showIntro = false;
          });
        }
      }
      print("Online Players $_onlinePlayers count ${_onlinePlayers.length}");
    });

    whisperChannel = _echo.private('challenge.${_challenge.id}.whisper');

    whisperChannel.listerForWhisper(
      'whispering',
      (data) {
        print('whispering');
      },
    );
  }

  void _whisper() {
    whisperChannel.whisper('whispering', json.encode({'data': 'data'}));
  }

  //Controller
  void _startGame() {
    setState(() {
      start = true;
      resume = true;
    });
  }

  @override
  void dispose() {
    _echo.leave('challenge.${_challenge.id}');
    _echo.leave('challenge.${_challenge.id}.whisper');
    _echo.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
        child: Builder(builder: (_) {
          if (showIntro && !start) {
            return IntroArea(
              me: _challenge.me,
              opponent: _challenge.opponent,
              startGame: _startGame,
            );
          } else if (start) {
            return QuestionItem();
          } else {
            // return QuestionItem();
            return WaitingArea();
          }
        }),
      ),
    );
  }
}
