import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelang_ujikom/screen/admin/main_admin.dart';
import 'package:lelang_ujikom/screen/login_screen.dart';
import 'package:lelang_ujikom/screen/petugas/main_petugas.dart';
import 'package:lelang_ujikom/screen/register_screen.dart';
import 'package:lelang_ujikom/screen/user/main_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Widget mainView = Login();

  if (FirebaseAuth.instance.currentUser != null) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == 'Admin') {
          mainView = MainAdmin();
        } else if (documentSnapshot.get('role') == 'Petugas') {
          mainView = MainPetugas();
        } else {
          mainView = MainUser();
        }
      }
    });
  }

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: mainView,
    theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent, elevation: 0.0)),
  ));
}
