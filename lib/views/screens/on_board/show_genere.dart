import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../constants/colors/constant_colors.dart';
import '../../../helper/button_helper.dart';
import '../../../helper/text_helper.dart';
import '../../../helper/text_input_controller.dart';

TextEditingController nameCtrl = TextEditingController();
String downloadURL = "";
String val = "";
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
    PlatformFile file = prevData["file"];
    if(prevData["cnt"] == 1){
      prevData["cnt"] = 0;
      uploadDocsToFirestore(file);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text("Song Genre"),
          backgroundColor: ConstantColors.mPrimaryColor,
          elevation: 0,
          shadowColor: Colors.transparent
      ),
      body: Center(
        child: Container(
          alignment: Alignment.centerLeft,
          constraints: const BoxConstraints(maxWidth: 500),
          margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: TextHelper.textWithColorSize(val, 30, Colors.green,fontWeight: FontWeight.w800),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<void> uploadDocsToFirestore(PlatformFile file) async {
    try {
      EasyLoading.show(status: "Uploading Song");


      final storageRef = FirebaseStorage.instance.ref();

      final songRef = storageRef.child("song.wav");

      String s = '';
      if(file != null) s = file.path!;
      File f = File(s);

      UploadTask uploadTask = songRef.putFile(f);

      downloadURL = await (await uploadTask.whenComplete(() => null))
          .ref
          .getDownloadURL();

      EasyLoading.dismiss();

      if(downloadURL == "") {
        cnt = 1;
        EasyLoading.dismiss();
        EasyLoading.showError("Image upload not working :(");
        return;
      }
      EasyLoading.dismiss();
      getTracks(downloadURL);
      return;
    } catch (e) {
      cnt = 1;
      EasyLoading.dismiss();
      EasyLoading.showError("Image upload not working :(");
      return ;
    }

  }

  Future<void> getTracks(String URL) async {
    var client = http.Client();
    EasyLoading.show(status: "Getting Genre");
    try {
      var url = Uri.https('tablature.onrender.com', 'getGenre');
      var response = await http.post(
          url,
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode({
            "filename": 'file.wav',
            "url": URL
          })
      );
      if(response.statusCode != 200){
        cnt = 1;
        EasyLoading.dismiss();
        EasyLoading.showError("ML model not working properly :-(");
        return;
      }
      setState(() {

        Map<String, dynamic> myMap = json.decode(response.body.toString());
        print(myMap.toString());
        val = myMap["result"].toString();

      });
    } catch (e){
      EasyLoading.dismiss();
      EasyLoading.showError("ML model not working :(");
      return;
    }
    finally {
      client.close();
    }
    EasyLoading.dismiss();
    return;
  }
}
