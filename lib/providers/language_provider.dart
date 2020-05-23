import 'package:bongo_quiz/resources.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  bool en = true;
  LanguageProvider(String language) {
    this.getLanguage();
  }

  bool get isEn {
    return this.en;
  }

  String term(String value) {
    return this.en ? value : LANGUAGE[value];
  }

  void getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('lang') ?? 'en';
    print("Language is $lang");
    this.en = lang == 'en';
    notifyListeners();
  }

  void setLanguage(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', value);
    final lang = prefs.getString('lang') ?? 'en';
    this.en = lang == 'en';
    notifyListeners();
  }
}
