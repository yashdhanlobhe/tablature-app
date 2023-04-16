
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors/constant_colors.dart';
import '../../../helper/text_helper.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AddCropScreenFarmerState createState() => _AddCropScreenFarmerState();
}

class _AddCropScreenFarmerState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text("About"),
          backgroundColor: ConstantColors.mPrimaryColor,
          elevation: 0,
          shadowColor: Colors.transparent
      ),
      body: Center(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(60),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/constants/gceklogo.png'),
                ),
              ),

            ),
            Container(
              color: Colors.white60,
            ),
            Container(
              alignment: Alignment.centerLeft,
              constraints: const BoxConstraints(maxWidth: 500),
              margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
              child: ListView(

                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    child: TextHelper.textWithColorSize("Cadenza", 30, ConstantColors.greyColor2,fontWeight: FontWeight.w800),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: TextHelper.textWithColorSize("Let the music speak!", 25, ConstantColors.mPrimaryColor,fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: Text(
                      "We are making your experience better by providing you with some new features all at one place!",
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      style:  GoogleFonts.montserrat(
                          textStyle: const TextStyle(color: Colors.black,fontSize: 15 , fontWeight: FontWeight.w400)
                      ),
                    )
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      child: Text(
                        "-- Developed by --",
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                        style:  GoogleFonts.montserrat(
                            textStyle: const TextStyle(color: Colors.black,fontSize: 15 , fontWeight: FontWeight.w800)
                        ),
                      )
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: TextHelper.textWithColorSize("Prof. B . S . Yelure", 20, Colors.black,fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: TextHelper.textWithColorSize("Prof. P . S . Patil", 20, Colors.black,fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: TextHelper.textWithColorSize("Apurva Pawar", 20, Colors.black,fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: TextHelper.textWithColorSize("Shreya Kumbhar", 20, Colors.black,fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: TextHelper.textWithColorSize("Yash Dhanlobhe", 20, Colors.black,fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}