import 'dart:convert';
import 'package:cadenza/helper/text_helper.dart';
import 'package:http/http.dart' as http;
import 'package:cadenza/constants/colors/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

String val = "";
String key = "";
int cnt = 1;


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
    if(cnt == 1){
      cnt = 0;
      getTabs(url, track);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text("Tabulator"),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextHelper.textWithColorSize(val, 15, Colors.black, fontWeight: FontWeight.w600)
                ],
              ),
            ],
          )
        ),
      ),
    );
  }



  Future<void> getTabs(String URL , String track) async {
    EasyLoading.show(status: "Getting Tablatures");
      var client = http.Client();
      try {
        var url = Uri.https('tablature.onrender.com', 'getTabs');
        var response = await http.post(
            url,
            headers: {
              "Content-type": "application/json",
              "Accept": "application/json",
            },
            body: jsonEncode({
              "filename": 'file.mid',
              "url": URL ,
              "track" : track
            })
        );
        if(response.statusCode != 200){
          EasyLoading.dismiss();
          EasyLoading.showError("Problem with ML Model :(");
          return;
        }
        setState(() {
            Map<String, dynamic> myMap = json.decode(response.body.toString());
            key = myMap["key"];
            List<dynamic> values = myMap["notes"];
            val = getStr(values);
        });
      } catch(e){
        cnt = 1;
        EasyLoading.dismiss();
        EasyLoading.showError("Problem with ML Model :(");
        return;
      } finally {
        client.close();
      }
      EasyLoading.dismiss();
      return;
  }

  String getStr(List<dynamic> values) {
      String s = "";

      List<dynamic> cur = [];

      for(int i= 0 ; i < values.length ; i++){
          cur.add(values[i]);
          if((i+1)%10 == 0){
              s += "\n";
              s += help(cur);
              s += "\n";
              cur.clear();
          }
      }
      s += "\n";
      s += help(cur);
      s += "\n";


      return s;
  }

  String help(List<dynamic> cur) {
    List<List<String>> list =
    [
      ['- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- '],
      ['- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- '],
      ['- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- '],
      ['- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- '],
      ['- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- '],
      ['- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- ','- '],
    ];

     for(int i = 0 ; i < cur.length ; i++){
        print(list[int.parse((cur[i][1]-1).toString())][i*3]);
        list[int.parse((cur[i][1]-1).toString())][(i+1)*3-1] = cur[i][2].toString();
     }
     String ans = "";
     for(int i = 0 ;i < 6 ; i++){
         if(i == 0) ans += "E  ";
         if(i == 1) ans += "A  ";
         if(i == 2) ans += "D  ";
         if(i == 3) ans += "G  ";
         if(i == 4) ans += "B  ";
         if(i == 5) ans += "E  ";

         for(int j = 0 ;j < 30 ; j++){
           ans += list[i][j].toString();
         }
         ans += "\n";
     }

     return ans;
  }
}
