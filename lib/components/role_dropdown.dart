import 'package:flutter/material.dart';
import 'package:lelang_ujikom/const/colors.dart';
import 'package:lelang_ujikom/const/const.dart';
import 'package:lelang_ujikom/widgets/normal_text.dart';
import 'package:lelang_ujikom/controller/petugas_controller.dart';

Widget roleDropdown(
    hint, List<String> list, dropvalue, PetugasController controller) {
  return DropdownButtonHideUnderline(
    child: DropdownButton(
      hint: normalText(text: "$hint", color: fontGrey),
      value: dropvalue.value == '' ? null : dropvalue.value,
      isExpanded: true,
      items: list.map((e) {
        return DropdownMenuItem(
          value: e,
          child: e.toString().text.make(),
        );
      }).toList(),
      onChanged: (newValue) {
        dropvalue.value = newValue.toString();
      },
    ),
  )
      .box
      .white
      .padding(const EdgeInsets.symmetric(horizontal: 4))
      .roundedSM
      .make();
}
