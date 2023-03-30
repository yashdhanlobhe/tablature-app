
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cadenza/constants/colors/constant_colors.dart';
import 'package:cadenza/helper/text_helper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../helper/button_helper.dart';
import '../../../helper/text_input_controller.dart';
String val = "";
class ShowResult extends StatefulWidget {
  const ShowResult({Key? key}) : super(key: key);

  @override
  _AddCropScreenFarmerState createState() => _AddCropScreenFarmerState();
}

class _AddCropScreenFarmerState extends State<ShowResult> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> prevData =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    String track = prevData["track"];
    String url = prevData["url"];
    getTabs(url, track);
    print("-------------------------------------------------");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Select Track"),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.transparent
      ),
      body: Center(
        child: Container(
          alignment: Alignment.centerLeft,
          constraints: const BoxConstraints(maxWidth: 500),

          margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(val)
            ],
          ),
        ),
      ),
    );
  }



  Future<void> getTabs(String URL , String num) async {
      var client = http.Client();
      try {
        print("jere");
        var url = Uri.https('tablature.onrender.com', 'getTabs');
        print(url);
        var response = await http.post(url,headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        }, body: jsonEncode(
            {"filename": 'fileeeee.mid', "url": URL , "track" : num}));
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      setState(() {
        val = response.body.toString();
      });

      } finally {
      client.close();
      }
  }
}
