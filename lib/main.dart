import 'dart:io';

import 'package:bongo_quiz/providers/auth_provider.dart';
import 'package:bongo_quiz/providers/home_provider.dart';
import 'package:bongo_quiz/providers/language_provider.dart';
import 'package:bongo_quiz/providers/topic_details_provider.dart';
import 'package:bongo_quiz/providers/topics_provider.dart';
import 'package:bongo_quiz/providers/user_channel_provider.dart';
import 'package:bongo_quiz/screens/auth/auth_screen.dart';
import 'package:bongo_quiz/screens/home/home_screen.dart';
import 'package:bongo_quiz/screens/home/topics_page/category_topics.dart';
import 'package:bongo_quiz/screens/play_screen.dart/play_screen.dart';
import 'package:bongo_quiz/screens/topic_detail_screen/topic_details_screen.dart';
import 'package:bongo_quiz/screens/welcome/welcome_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  final token = pref.getString('_token') ?? null;
  final lang = pref.getString('lang') ?? 'en';
  var hasVisited = token == null ? false : true;

  final tempDir = (await getTemporaryDirectory()).path;
  String _screenShotDir = "$tempDir/screenshot";
  Directory(_screenShotDir).create().then((directory) => print(directory.path));

  runApp( MyApp(hasVisited: hasVisited, language: lang));
}

dynamic _checkConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    print(result);
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
    }
  } on SocketException catch (_) {
    throw ('error');
  }
}

class MyApp extends StatelessWidget {
  final bool hasVisited;
  final String language;

  MyApp({this.hasVisited, this.language});
  @override
  Widget build(BuildContext context) {
    print(hasVisited ? "Visited" : 'New');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LanguageProvider(language)),
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProvider.value(value: HomeProvider()),
        ChangeNotifierProvider.value(value: TopicsProvider()),
        ChangeNotifierProvider.value(value: TopicDetailsProvider()),
        ChangeNotifierProvider.value(value: UserChannelProvider(hasVisited)),
      ],
      child: ThemeProvider(
        saveThemesOnChange: true,
        loadThemeOnInit: true,
        themes: [
          AppTheme.light().copyWith(
            id: "theme1",
            description: "First Theme",
            data: ThemeData(
              accentColor: Color.fromRGBO(255, 99, 71, 1),
              primaryColor: Colors.blue,
              scaffoldBackgroundColor: Color.fromRGBO(245, 255, 250, 1),
              bottomAppBarColor: Colors.blue,
              textTheme: TextTheme(
                headline4: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
                headline5: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
                subtitle1: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          AppTheme.dark().copyWith(
            id: "theme2",
            description: "Second Theme",
            data: ThemeData(
              primaryColor: Colors.redAccent,
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Bongo Quiz',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: hasVisited ? HomePage.route : AuthScreen.route,
          routes: {
            WelcomeScreen.route: (_) => ThemeConsumer(child: WelcomeScreen()),
            AuthScreen.route: (_) => ThemeConsumer(child: AuthScreen()),
            HomePage.route: (_) => ThemeConsumer(child: HomePage()),
            CategoryTopics.route: (_) => ThemeConsumer(child: CategoryTopics()),
            TopicDetailsScreen.route: (_) =>
                ThemeConsumer(child: TopicDetailsScreen()),
            PlayScreen.route: (_) => ThemeConsumer(child: PlayScreen()),
          },
        ),
      ),
    );
  }
}
