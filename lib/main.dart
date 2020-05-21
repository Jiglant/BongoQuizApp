import 'package:bongo_quiz/screens/auth/auth_screen.dart';
import 'package:bongo_quiz/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  final token = pref.getString('token') ?? null;
  var hasVisited = token == null ? false : true;
  runApp(MyApp(hasVisited: hasVisited));
}

class MyApp extends StatelessWidget {
  final bool hasVisited;

  MyApp({this.hasVisited});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(hasVisited ? "Visited" : 'New');
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: [
        AppTheme.light().copyWith(
          id: "theme1",
          description: "First Theme",
          data: ThemeData(
            primaryColor: Colors.blue,
            
          ),
        ),AppTheme.light().copyWith(
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
        initialRoute: hasVisited?HomePage.route:AuthScreen.route,
        routes: {
          AuthScreen.route: (_) => ThemeConsumer(child: AuthScreen()),
          HomePage.route: (_) => ThemeConsumer(child: HomePage()),
        },
      ),
    );
  }
}
