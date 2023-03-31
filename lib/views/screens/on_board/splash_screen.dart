
import 'package:cadenza/constants/colors/constant_colors.dart';
import 'package:cadenza/helper/text_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);


  Future<void> waitingState(BuildContext context) async {
    await Firebase.initializeApp();
    await Future.delayed(const Duration(milliseconds: 1950), () {});
    Navigator.pushReplacementNamed(
      context,
      '/selectSound'
    );
  }

  @override
  Widget build(BuildContext context) {
    waitingState(context);
    return Scaffold(
        backgroundColor: ConstantColors.mPrimaryColor,
        body: Stack(
          children: [
            Container(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('lib/constants/background.jpg'),
                      fit: BoxFit.fitHeight),
                ),

              ),
            ),
            Container(
              color: Colors.black45,
            ),
            Center(
              child: TextHelper.textWithColorSize(
                  "Cadenza", 40, Colors.white,
                  fontWeight: FontWeight.w800),
            )
          ],
        )
    );
  }
}