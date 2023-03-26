import 'package:flutter/material.dart';
import 'package:lelang_ujikom/const/colors.dart';
import 'package:lelang_ujikom/const/const.dart';

Widget GambarBarang({required Label, onPress}) {
  return "$Label"
      .text
      .bold
      .color(fontGrey)
      .size(16.0)
      .makeCentered()
      .box
      .color(lightGrey)
      .size(100, 100)
      .roundedSM
      .make();
}
