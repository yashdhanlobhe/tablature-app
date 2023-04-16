import 'package:cadenza/views/screens/on_board/select_music_from_strorage_screen.dart';
import 'package:cadenza/views/screens/on_board/select_track_screen.dart';
import 'package:cadenza/views/screens/on_board/show_genere.dart';
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
        '/splashScreen' : (ctx) => const SplashScreen(),
        '/selectSound/selectTrack' : (ctx) => const SelectTrack(),
        '/selectSound' : (ctx) => const SelectSound(),
        '/selectSound/selectTrack/showTabResult' : (ctx) => const ShowResult(),
        '/selectSound/songGenre' : (ctx) => const ShowGenre()
      },
      initialRoute: '/splashScreen',
    );
  }
}
