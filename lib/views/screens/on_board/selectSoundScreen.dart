
import 'package:cadenza/constants/colors/constant_colors.dart';
import 'package:cadenza/helper/text_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../helper/button_helper.dart';
import '../../../helper/text_input_controller.dart';
import 'package:file_picker/file_picker.dart';

TextEditingController cropName = TextEditingController();
String songName = "Song Name";
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
        title: const Text("Select Sound"),
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

              TextHelper.textWithColorSize(songName, 20, ConstantColors.mPrimaryColor),

              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 20, bottom: 30),
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    var file = await FilePicker.platform.pickFiles(allowMultiple: true);

                    // if no file is picked
                    if (file == null) return;
                    // we get the file from result object
                    result = file.files.first;

                    setState(() {
                      songName = result.name;
                    });
                  },
                  child: TextHelper.textWithColorSize("Select Song",
                      18, Colors.white , fontWeight: FontWeight.w700),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      backgroundColor: MaterialStateColor.resolveWith(
                              (states) => ConstantColors.mPrimaryColor)),
                )
              ),

              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 20, bottom: 30),
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pushReplacementNamed(
                        context,
                        '/selectSound/selectTrack',
                        arguments: {
                          "file" : result
                        }
                      );
                    },
                    child: TextHelper.textWithColorSize("Get Tracks",
                        18, Colors.white , fontWeight: FontWeight.w700),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        backgroundColor: MaterialStateColor.resolveWith(
                                (states) => ConstantColors.mPrimaryColor)),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }




}
