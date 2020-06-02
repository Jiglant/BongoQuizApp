import 'dart:convert';
import 'dart:io';

import 'package:bongo_quiz/model/category.dart';
import 'package:bongo_quiz/model/topic.dart';
import 'package:bongo_quiz/resources.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TopicsProvider with ChangeNotifier {
  List<MyCategory> _categories = [];
  List<Topic> _categoryTopics = [];
  String nextTopicsPageUrl;
  List<String> loadedTopicsPage = [];

//Categories
  List<MyCategory> get categories {
    return [..._categories];
  }

  Future<void> loadCategories() async {
    try {
      final result = await executeUrl(TOPICS_ROUTE);
      // print(result);
      if (result.containsKey('message') &&
          result['message'] == 'Unauthenticated.') {
        throw ('Unauthenticated');
      } else if (result.containsKey('data')) {
        List<MyCategory> items = [];
        final data = result['data'] as List<dynamic>;
        data.forEach((cat) {
          var topics = (cat['topics'] as List<dynamic>)
              .map((topic) => Topic(
                    id: topic['id'],
                    name: topic['name'],
                    description: topic['description'],
                    imageUrl: topic['imageUrl'],
                  ))
              .toList();
          List<Topic> l = [];
          l.addAll(topics);
          l.addAll(topics);
          l.addAll(topics);
          l.addAll(topics);
          l.addAll(topics);

          items.add(MyCategory(
            id: cat['id'],
            name: cat['name'],
            topics: l,
          ));
        });
        _categories.addAll(items);
        _categories.addAll(items);
        _categories.addAll(items);
        _categories.addAll(items);
        _categories.addAll(items);
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

//Topics

  List<Topic> get categoryTopics {
    return [..._categoryTopics];
  }

  Future<void> loadCateoryTopics(int categoryId) async {
    try {
      _categoryTopics.clear();
      final result =
          await executeUrl("$CATEGORY_TOPICS_ROUTE$categoryId/topics");
      // print(result);
      if (result.containsKey('message') &&
          result['message'] == 'Unauthenticated.') {
        throw ('Unauthenticated');
      } else if (result.containsKey('data')) {
        final data = result['data'] as List<dynamic>;
        nextTopicsPageUrl = result['links']['next'];
        List<Topic> items = [];
        data.forEach((topic) {
          items.add(Topic(
            id: topic['id'],
            name: topic['name'],
            description: topic['description'],
            imageUrl: topic['imageUrl'],
          ));
        });
        _categoryTopics.addAll(items);
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

  Future<void> loadMoreCateoryTopics() async {
    try {
      if (nextTopicsPageUrl == null ||
          loadedTopicsPage.contains(nextTopicsPageUrl)) {
        return;
      }
      loadedTopicsPage.add(nextTopicsPageUrl);
      final result = await executeUrl(nextTopicsPageUrl);
      // print(result);
      if (result.containsKey('message') &&
          result['message'] == 'Unauthenticated.') {
        throw ('Unauthenticated');
      } else if (result.containsKey('data')) {
        final data = result['data'] as List<dynamic>;
        nextTopicsPageUrl = result['links']['next'];
        List<Topic> items = [];
        data.forEach((topic) {
          items.add(Topic(
            id: topic['id'],
            name: topic['name'],
            description: topic['description'],
            imageUrl: topic['imageUrl'],
          ));
        });
        _categoryTopics.addAll(items);
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

  //Topic Details
  // Future<void> loadTopicDetails(int topicId) async {
  //   try {
  //     _categoryTopics.clear();
  //     final result = await executeUrl("$TOPIC_DETAILS_ROUTE$topicId");
  //     // print(result);
  //     if (result.containsKey('message') &&
  //         result['message'] == 'Unauthenticated.') {
  //       throw ('Unauthenticated');
  //     } else if (result.containsKey('data')) {
  //       final data = result['data'] as Map<String,dynamic>;
        
  //       //TODO Create topic details model

  //       notifyListeners();
  //     } else {
  //       throw ('error');
  //     }
  //   } on SocketException catch (error) {
  //     throw ('connection_error');
  //   } catch (error) {
  //     throw (error);
  //   }
  // }

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
