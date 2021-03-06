import 'dart:convert';
import 'dart:io';

import 'package:bongo_quiz/model/topic.dart';
import 'package:bongo_quiz/resources.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider with ChangeNotifier {
  List<Topic> _favorites = [];
  String nextFavoritePageUrl;
  List<String> loadedFavoritePage = [];
  //new topics
  List<Topic> _newTopics = [];

  //FAVORITE
  List<Topic> get favoriteTopics {
    return [..._favorites];
  }

  Future<void> loadFavorites() async {
    try {
      final result = await executeUrl(FAVORITE_ROUTE);
      // print(result);
      if (result.containsKey('message') &&
          result['message'] == 'Unauthenticated.') {
        throw ('Unauthenticated');
      } else if (result.containsKey('data')) {
        nextFavoritePageUrl = result['links']['next'];
        List<Topic> items = [];
        final data = result['data'] as List<dynamic>;
        data.forEach((topic) {
          items.add(Topic(
            id: topic['id'],
            name: topic['name'],
            description: topic['description'],
            imageUrl: topic['imageUrl'],
          ));
        });
        _favorites = items;
        notifyListeners();
      } else {
        throw ('error');
      }
    } catch (error) {
      throw (error);
    }
  }

  void loadMoreFavorites() async {
    try {
      if (nextFavoritePageUrl == null ||
          loadedFavoritePage.contains(nextFavoritePageUrl)) {
        return;
      }
      loadedFavoritePage.add(nextFavoritePageUrl);
      final result = await executeUrl(nextFavoritePageUrl);
      // print(result);
      if (result.containsKey('message') &&
          result['message'] == 'Unauthenticated.') {
        throw ('Unauthenticated');
      } else if (result.containsKey('data')) {
        nextFavoritePageUrl = result['links']['next'];
        List<Topic> items = [];
        final data = result['data'] as List<dynamic>;
        data.forEach((topic) {
          items.add(Topic(
            id: topic['id'],
            name: topic['name'],
            description: topic['description'],
            imageUrl: topic['imageUrl'],
          ));
        });
        _favorites.addAll(items);
        notifyListeners();
      } else {
        throw ('error');
      }
    } catch (error) {
      throw (error);
    }
  }

  //NEW TOPICS
  List<Topic> get newTopics {
    return [..._newTopics];
  }

  Future<void> loadNewTopics() async {
    try {
      final result = await executeUrl(NEW_TOPIC_ROUTE);
      // print(result);
      if (result.containsKey('message') &&
          result['message'] == 'Unauthenticated.') {
        throw ('Unauthenticated');
      } else if (result.containsKey('data')) {
        List<Topic> items = [];
        final data = result['data'] as List<dynamic>;
        data.forEach((topic) {
          items.add(Topic(
            id: topic['id'],
            name: topic['name'],
            description: topic['description'],
            imageUrl: topic['imageUrl'],
          ));
        });
        _newTopics = items;
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
    final token = prefs.getString('_token') ?? '';
    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    return json.decode(response.body) as Map<String, dynamic>;
  }
}
