import 'dart:convert';
import 'dart:io';

import 'package:bongo_quiz/model/friend.dart';
import 'package:bongo_quiz/model/topic_details.dart';
import 'package:bongo_quiz/resources.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TopicDetailsProvider with ChangeNotifier {
  TopicDetails _details;
  String nextFriendsPageUrl;
  List<String> loadedFriendsPages = [];

  TopicDetails get details {
    return _details;
  }

  int get currentLevel {
    return details.playerLevel ~/ 10;
  }

  double get currentLevelPercent {
    return (details.playerLevel % 10) / 10;
  }

  //Topic Details
  Future<void> loadTopicDetails(int topicId) async {
    try {
      final result = await executeUrl("$TOPIC_DETAILS_ROUTE$topicId");
      // print(result);
      if (result.containsKey('message') &&
          result['message'] == 'Unauthenticated.') {
        throw ('Unauthenticated');
      } else if (result.containsKey('data')) {
        final data = result['data'] as Map<String, dynamic>;
        nextFriendsPageUrl = data['friends']['next_page_url'];
        List<Friend> fake = [
          Friend(id: 1,name: "Jiglant",avatar: ""),
          Friend(id: 1,name: "Kalla",avatar: ""),
          Friend(id: 1,name: "Noel",avatar: ""),
          Friend(id: 1,name: "Hans",avatar: "http://192.168.43.136:8000/image/1"),
          Friend(id: 1,name: "Kelcin",avatar: ""),
          Friend(id: 1,name: "Jiglant",avatar: ""),
          Friend(id: 1,name: "Kalla",avatar: ""),
          Friend(id: 1,name: "Noel",avatar: ""),
          Friend(id: 1,name: "Hans",avatar: "http://192.168.43.136:8000/image/1"),
          Friend(id: 1,name: "Kelcin",avatar: ""),
          Friend(id: 1,name: "Jiglant",avatar: ""),
          Friend(id: 1,name: "Kalla",avatar: ""),
        ];
        _details = TopicDetails(
          id: data['id'],
          name: data['name'],
          imageUrl: data['imageUrl'],
          followersCount: data['followers_count'],
          playerLevel: data['player_level'],
          isFollowing: data['isFollowing'],
          rankings: data['rankings'],
          friends: fake
          // (data['friends']['data'] as List<dynamic>)
          //     .map((friend) => Friend(
          //           id: friend['id'],
          //           name: friend['name'],
          //           avatar: friend['avatar'],
          //         ))
          //     .toList(),
        );

        notifyListeners();
      } else {
        throw ('error');
      }
    } on SocketException catch (error) {
      throw ('connection_error');
    } catch (error) {
      throw (error);
    }
  }

  Future<Map<String, dynamic>> executeUrl(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('_token') ?? '';
    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    return json.decode(response.body) as Map<String, dynamic>;
  }
}
