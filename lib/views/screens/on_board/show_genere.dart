import 'dart:convert';
import 'dart:io';
import 'package:cadenza/constants/colors/constant_colors.dart';
import 'package:cadenza/helper/text_helper.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../helper/button_helper.dart';
import '../../../helper/text_input_controller.dart';
TextEditingController nameCtrl = TextEditingController();
String downloadURL = "";
String val = "";
int cnt = 1;

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
    if(cnt == 1){
      cnt = 0;
      uploadDocsToFirestore(file);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Select Track"),
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
                    child: TextHelper.textWithColorSize(val, 18, ConstantColors.mPrimaryColor,fontWeight: FontWeight.w500),
                  ),
                  TextInputController.simpleTextInputController(context , "Enter Track Name" ,  nameCtrl),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 20, bottom: 30),
                      height: 48,
                      child: ButtonHelper.getElevatedButton(
                        "Get Tabs", () async {
                        if(nameCtrl.text == ""){
                          EasyLoading.showError("Enter track number please...");
                          return;
                        }
                        if(downloadURL == ""){
                          EasyLoading.showError("Problem with Firebase...");
                          return;
                        }
                        Navigator.pushNamed(
                            context,
                            '/selectSound/selectTrack/showTabResult',
                            arguments: {
                              "track" : nameCtrl.text,
                              "url" : downloadURL
                            }
                        );
                      },
                      )
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
      EasyLoading.show(status: "Uploading Image");

      FirebaseStorage storage = FirebaseStorage.instance;
      Reference referenceProfile = storage.ref().child("file.mid");
      String s = '';
      if(file != null) s = file.path!;
      File f = new File(s);

      UploadTask uploadTask = referenceProfile.putFile(f);

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
      EasyLoading.show(status: "Generating Tracks");
      try {
          var url = Uri.https('tablature.onrender.com', 'getTracks');
          var response = await http.post(
              url,
              headers: {
                "Content-type": "application/json",
                "Accept": "application/json",
              },
              body: jsonEncode({
                "filename": 'file.mid',
                "url": URL
              })
          );
          if(response.statusCode != 200){
            cnt = 1;
            EasyLoading.dismiss();
            EasyLoading.showError("ML model not working properly :(");
            return;
          }
          setState(() {
            Map<String, dynamic> myMap = json.decode(response.body.toString());
            myMap.forEach((key, value) {
                  val += ""+key.toString()+" = "+ value.toString() +"\n";
            });
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
