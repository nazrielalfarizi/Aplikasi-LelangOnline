import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelang_ujikom/const/const.dart';

import '../const/firebase_const.dart';

class ProfileControler extends GetxController {
  late QueryDocumentSnapshot snapshotData;

  var namaController = TextEditingController();
  var changePassController = TextEditingController();
  var AlamatController = TextEditingController();
  var noTelpController = TextEditingController();

//bisa untuk ngebid buat simpen data history lelang sesuai email
  // updateProfile({nama, password, alamat, notelp}) async {
  //   String? email = auth.currentUser!.email;
  //   var store = firestore.collection(userCollection).doc(email);
  //   await store.set({
  //     'nama_user': nama,
  //     'password': password,
  //     'alamat': alamat,
  //     'notelp': notelp
  //   });
  // }

  updateProfile({nama, password, alamat, notelp}) async {
    var store = firestore
        .collection(userCollection)
        .where('email', isEqualTo: currentUser!.email)
        .limit(1)
        .get();
    var doc = (await store).docs[0];
    await doc.reference.update({
      'nama_user': nama,
      'password': changePassController.text,
      'alamat': alamat,
      'notelp': notelp,
    });
  }

  changeAuthPassword() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String newPassword = changePassController.text;
      await user!.updatePassword(newPassword);

      print("Password updated successfully!");
    } catch (e) {
      print("Error occurred while updating password: $e");
    }
  }
}
