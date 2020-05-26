import 'package:bongo_quiz/providers/auth_provider.dart';
import 'package:bongo_quiz/providers/language_provider.dart';
import 'package:bongo_quiz/screens/auth/auth_screen.dart';
import 'package:bongo_quiz/screens/home/home_screen.dart';
import 'package:bongo_quiz/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  final token = pref.getString('_token') ?? null;
  final lang = pref.getString('lang') ?? 'en';
  var hasVisited = token == null ? false : true;

  runApp(MyApp(hasVisited: true, language: lang));
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
          initialRoute: hasVisited ? HomePage.route : WelcomeScreen.route,
          routes: {
            WelcomeScreen.route: (_) => ThemeConsumer(child: WelcomeScreen()),
            AuthScreen.route: (_) => ThemeConsumer(child: AuthScreen()),
            HomePage.route: (_) => ThemeConsumer(child: HomePage()),
          },
        ),
      ),
    );
  }
}
