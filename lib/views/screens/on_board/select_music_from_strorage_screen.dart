
import 'package:cadenza/constants/colors/constant_colors.dart';
import 'package:cadenza/helper/text_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../helper/button_helper.dart';
import '../../../helper/text_input_controller.dart';
import 'package:file_picker/file_picker.dart';

TextEditingController cropName = TextEditingController();
String songName = "";
var result = null;



class SelectSound extends StatefulWidget {
  const SelectSound({Key? key}) : super(key: key);

  @override
  _AddCropScreenFarmerState createState() => _AddCropScreenFarmerState();
}

class _AddCropScreenFarmerState extends State<SelectSound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(child: Text("Cadenze"),),
        backgroundColor: ConstantColors.mPrimaryColor,
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
                child: TextHelper.textWithColorSize(songName, 20, ConstantColors.mPrimaryColor),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.black, width: 1.0),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 20, bottom: 30),
                height: 48,
                child: ButtonHelper.getElevatedButton(
                  "Select Song", () async {
                    var file = await FilePicker.platform.pickFiles(allowMultiple: true);
                    if (file == null) return;
                    result = file.files.first;
                    setState(() {
                      songName = result.name;
                    });
                  },
                )
              ),

              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 20, bottom: 30),
                  height: 48,
                  child: ButtonHelper.getElevatedButton(
                    "Get Tablature", () async {
                      if(result == null){
                        EasyLoading.showError("Bhai song select to kar...");
                        return;
                      }
                      Navigator.pushNamed(
                          context,
                          '/selectSound/selectTrack',
                          arguments: {
                            "file" : result
                          }
                      );
                    },
                  )
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 20, bottom: 30),
                  height: 48,
                  child: ButtonHelper.getElevatedButton(
                    "Get Genre", () async {

                     },
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }




}
