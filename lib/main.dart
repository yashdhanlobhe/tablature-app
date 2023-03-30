import 'package:cadenza/views/screens/on_board/selectSoundScreen.dart';
import 'package:cadenza/views/screens/on_board/selectTrack.dart';
import 'package:cadenza/views/screens/on_board/showResult.dart';
import 'package:cadenza/views/screens/on_board/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
      ),
      routes: {
        '/splashScreen' : (ctx) => SplashScreen(),
        '/selectSound/selectTrack' : (ctx) => SelectTrack(),
        '/selectSound' : (ctx) => SelectSound(),
        '/selectSound/selectTrack/showTabResult' : (ctx) => ShowResult()
      },
      initialRoute: '/splashScreen',
    );
  }
}
