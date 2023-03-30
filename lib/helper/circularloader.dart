import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors/constant_colors.dart';

class MLoader{
  static Widget mLoader(double size){
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        backgroundColor: ConstantColors.mPrimaryColor,
      ),
    );
  }
}