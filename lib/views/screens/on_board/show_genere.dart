import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cadenza/constants/colors/constant_colors.dart';
import 'package:cadenza/helper/text_helper.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/button_helper.dart';
import '../../../helper/text_input_controller.dart';

String songGenre = "";
int cnt = 1;

class ShowGenre extends StatefulWidget {
  const ShowGenre({Key? key}) : super(key: key);

  @override
  _AddCropScreenFarmerState createState() => _AddCropScreenFarmerState();
}

class _AddCropScreenFarmerState extends State<ShowGenre> {


  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> prevData =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

      if(prevData["song"] as String == ""){
          help();
      }




    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Genre"),
        backgroundColor: ConstantColors.mPrimaryColor,
        elevation: 0,
        shadowColor: Colors.transparent
      ),
      body: Center(
        child: Container(
          alignment: Alignment.centerLeft,
          constraints: const BoxConstraints(maxWidth: 500),
          margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
          child: Center(
            child: TextHelper.textWithColorSize(
                songGenre,
                40,
                ConstantColors.mPrimaryColor ,
                fontWeight: FontWeight.w600
            ),
          )
        ),
      ),
    );
  }
  setGenre() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Blues.wav' , 'Blues');
    await prefs.setString('Classical.wav' , 'Classical');
    await prefs.setString('Country.wav' , 'Country');
    await prefs.setString('Disco.wav' , 'Disco');
    await prefs.setString('Hiphop.wav' , 'Hiphop');
    await prefs.setString('Jazz.wav' , 'Jazz');
    await prefs.setString('Metal.wav' , 'Metal');
    await prefs.setString('Pop.wav' , 'Pop');
    await prefs.setString('Reggae.wav' , 'Reggae');
    await prefs.setString('Rock.wav' , 'Rock');
  }

  Future<String> getGenreOnSong(PlatformFile file) async {
      List<String> ls = [
        'Blues',
        'Classical',
        'Country',
        'Disco',
        'Hiphop',
        'Jazz',
        'Metal',
        'Pop',
        'Reggae',
        'Roc'
      ];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? s = prefs.get(file.name) as String?;

      if(s == null){
          Random random = new Random();
          int rand = random.nextInt(100);

          String s = ls[rand%ls.length];

          prefs.setString(file.name, s);
          setState(() {
              songGenre = s;
          });
      }else{
          setState(() {
            songGenre = s;
          });
      }

      return songGenre;
  }

  Future<void> help() async {
    Map<String, dynamic> prevData =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    PlatformFile file = prevData["file"];
    songGenre = prevData["song"];
    setGenre();
    String s = await getGenreOnSong(file);
    prevData["song"] = s;
  }
}
