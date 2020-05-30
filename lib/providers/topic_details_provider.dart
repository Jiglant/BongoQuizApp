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
        _details = TopicDetails(
          id: data['id'],
          name: data['name'],
          imageUrl: data['imageUrl'],
          followersCount: data['followers_count'],
          playerLevel: data['player_level'],
          isFollowing: data['isFollowing'],
          rankings: data['rankings'],
          friends: (data['friends']['data'] as List<dynamic>)
              .map((friend) => Friend(
                    id: friend['id'],
                    name: friend['name'],
                    avatar: friend['avatar'],
                  ))
              .toList(),
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
    // final token = prefs.getString('_token') ?? '';
    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $TOKEN"
    });
    return json.decode(response.body) as Map<String, dynamic>;
  }
}
