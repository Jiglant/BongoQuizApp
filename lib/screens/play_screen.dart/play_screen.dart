import 'dart:convert';

import 'package:bongo_quiz/model/challenge.dart';
import 'package:bongo_quiz/providers/user_channel_provider.dart';
import 'package:bongo_quiz/resources.dart';
import 'package:bongo_quiz/screens/play_screen.dart/intro_area.dart';
import 'package:bongo_quiz/screens/play_screen.dart/question_item/question_item.dart';
import 'package:bongo_quiz/screens/play_screen.dart/waiting_area.dart';
import 'package:bongo_quiz/shared/custom_dialog.dart';
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
  bool gameOver = false;
  int currentQuestion = 0;
  PageController _pageController;

  List<dynamic> _onlinePlayers = [];
  Map<String, dynamic> _playerAnswers = {
    'me': [],
    'opponent': [
      // {'qns_id': 2, 'ans_id': 2, 'win': false, 'image': 'screenshot'},
    ]
  };

  @override
  void initState() {
    _pageController = PageController(initialPage: currentQuestion);
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
      if (_challenge == null) {
        _challenge = provider.convertToChallenge(data);
      }

      listenForChallenge(); // TODO uncomment to listen the challenge channel
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
      if (_onlinePlayers.length > 1 && !start) {
        _showIntro();
      }
    }).joining((user) {
      print("jouning $user");
      if (!_onlinePlayers.contains(user)) {
        _onlinePlayers.add(user);
        if (_onlinePlayers.length > 1 && start) {
          resumeGame();
        } else if (_onlinePlayers.length > 1 && !start) {
          _showIntro();
        }
      }
      print("Online Players $_onlinePlayers");
    }).leaving((user) {
      print("Leaving $user");
      if (!_onlinePlayers.contains(user)) {
        _onlinePlayers.removeWhere((player) => player['id'] == user['id']);
        if (_onlinePlayers.length < 2 && start) {
          pauseGame();
        }
      }
      print("Online Players $_onlinePlayers count ${_onlinePlayers.length}");
    });

    whisperChannel = _echo.private('challenge.${_challenge.id}.whisper');

    whisperChannel.listerForWhisper(
      'answerChoosed',
      (data) {
        final opponentAnswer = json.decode(data);
        // print("from opponent $opponentAnswer");
        (_playerAnswers['opponent'] as List<dynamic>).add(opponentAnswer);
        setState(() {});
      },
    );
  }

  void _whisperAnswer(Map<String, dynamic> data) {
    print('start whispering');
    (_playerAnswers['me'] as List<dynamic>).add(data);
    whisperChannel.whisper('answerChoosed', json.encode(data));
  }

  //Controller
  void _showIntro() {
    setState(() {
      showIntro = true;
    });
  }

  void _startGame() {
    if (_onlinePlayers.length > 1) {
      setState(() {
        start = true;
        resume = true;
      });
    } else {
      setState(() {
        start = true;
      });
      pauseGame();
    }
  }

  void pauseGame() {
    setState(() {
      resume = false;
    });
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pop();
    });
  }

  void resumeGame() {
    setState(() {
      resume = true;
    });
  }

  void endGame() {
    setState(() {
      gameOver = true;
    });
  }

  void _nextQuestion() {
    if (currentQuestion < _challenge.questions.length - 1) {
      currentQuestion++;
      _pageController.jumpToPage(currentQuestion);
    } else {
      endGame();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _echo.leave('challenge.${_challenge.id}');
    _echo.leave('challenge.${_challenge.id}.whisper');
    _echo.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(json.encode(_playerAnswers));
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
          } else if (showIntro && start && !gameOver) {
            return Stack(
              children: <Widget>[
                PageView.builder(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _challenge.questions.length,
                  itemBuilder: (ctx, index) {
                    return QuestionItem(
                        round: (index + 1),
                        question: _challenge.questions[index],
                        nextQns: _nextQuestion,
                        me: _challenge.me,
                        opponent: _challenge.opponent,
                        whisperAnswer: _whisperAnswer,
                        opponentAnswers: _playerAnswers['opponent'],
                        myAnswers: _playerAnswers['me']);
                  },
                ),
                Visibility(
                  visible: start && !resume,
                  child: Container(
                    color: Colors.black87,
                    child: SizedBox.expand(
                      child: Center(
                        child: Text(
                          "Opponent has left the Challenge!",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          } else if (start && gameOver) {
            return Container(
              color: Colors.black87,
              child: SizedBox.expand(
                child: Center(
                  child: Text(
                    "Game Over",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            );
          } else {
            return WaitingArea();
          }
        }),
      ),
    );
  }
}
