import 'package:flutter/material.dart';
import 'package:lelang_ujikom/const/colors.dart';

Widget LoadingIndicator() {
  return const Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(fontGrey),
    ),
  );
}
