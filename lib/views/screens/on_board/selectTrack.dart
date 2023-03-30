
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
TextEditingController nameCtrl = TextEditingController();
String dowurl = "";
String val = "No Re";
class SelectTrack extends StatefulWidget {
  const SelectTrack({Key? key}) : super(key: key);

  @override
  _AddCropScreenFarmerState createState() => _AddCropScreenFarmerState();
}

class _AddCropScreenFarmerState extends State<SelectTrack> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> prevData =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    PlatformFile file = prevData["file"];
    uploadDocsToFirestore(file);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Select Track"),
        backgroundColor: Colors.white,
        elevation: 0,
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
                Container(
                  child: Text(val)
                ),
              TextInputController.simpleTextInputController(context , "Full Name" ,  nameCtrl),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 20 , bottom: 30),
                height: 48,
                child: ButtonHelper.getElevatedButton("Sign Up", () {
                  Navigator.pushNamed(
                      context,
                      '/selectSound/selectTrack/showTabResult',
                      arguments: {
                        "track" : nameCtrl.text,
                        "url" : dowurl
                      }
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<String> uploadDocsToFirestore(PlatformFile file) async {
    try {
      //upload profile image
      // EasyLoading.show(dismissOnTap: true, status: "Uploading Image");

      FirebaseStorage storage = FirebaseStorage.instance;
      Reference referenceProfile = storage.ref().child(
          "hello.mid");
      String s = '';
      if(file != null) s = file.path!;
      File f = new File(s);
      print(file.path);
      UploadTask uploadTask =
      referenceProfile.putFile(f);

      dowurl = await (await uploadTask.whenComplete(() => null))
          .ref
          .getDownloadURL();

      print("certificateURL : " + dowurl);
      getTracks(dowurl);
      EasyLoading.dismiss();
      return dowurl;
    } catch (e) {
      print(e.toString());
      EasyLoading.showError("Something Went Wrong :(");
      return "false";
    }

  }

  Future<void> getTracks(String URL) async {
      var client = http.Client();
      try {
        print("jere");
        var url = Uri.https('tablature.onrender.com', 'getTracks');
        print(url);
        var response = await http.post(url,headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        }, body: jsonEncode(
            {"filename": 'fileeeee.mid', "url": URL}));
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
