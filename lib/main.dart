import 'package:cadenza/views/screens/on_board/select_music_from_strorage_screen.dart';
import 'package:cadenza/views/screens/on_board/select_track_screen.dart';
import 'package:cadenza/views/screens/on_board/tabs_generation_screen.dart';
import 'package:cadenza/views/screens/on_board/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      builder: EasyLoading.init(),
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
