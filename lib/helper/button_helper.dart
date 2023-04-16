import 'package:cadenza/helper/text_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors/constant_colors.dart';

class ButtonHelper{
  static Widget getElevatedButton(String text , var fun ,
      {Color color = Colors.black45}){
    if(color == Colors.black45) color = ConstantColors.mPrimaryColor;
    return ElevatedButton(
      onPressed: fun,
      child: TextHelper.textWithColorSize(text,
          18, Colors.white , fontWeight: FontWeight.w700),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          backgroundColor: MaterialStateColor.resolveWith(
                  (states) => color)),
    );
  }

  static Widget getTextButton(String text , var fun){
    return TextButton(
      onPressed: fun,
      child: TextHelper.textWithColorSize(text,
          18, Colors.blue , fontWeight: FontWeight.w400),
    );
  }
}