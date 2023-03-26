import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lelang_ujikom/models/role_model.dart';
import 'package:lelang_ujikom/screen/admin/petugas/petugas_screen.dart';
import 'package:lelang_ujikom/screen/admin/petugas/tambah_petugas.dart';
import 'package:lelang_ujikom/screen/login_screen.dart';

import '../const/const.dart';
import '../const/firebase_const.dart';

class PetugasController extends GetxController {
  // late QueryDocumentSnapshot snapshotData;
  PetugasScreen? view;
  var isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  var id = TextEditingController();
  var namaPetugasController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var noTelpController = TextEditingController();
  var alamatController = TextEditingController();

  var roleList = <String>[].obs;
  List<Role> role = [];
  var rolevalue = ''.obs;

  // uploadPetugas(context) async {
  //   var store = firestore.collection(userCollection).doc();
  //   await store.set({
  //     'id_user': store.id,
  //     'nama_petugas': namaPetugasController.text,
  //     'email': emailController.text,
  //     'password': passwordController.text,
  //     'notelp': noTelpController.text,
  //     'alamat': alamatController.text,
  //     'role': rolevalue.value
  //   });
  //   isLoading(false);
  //   VxToast.show(context, msg: "Petugas Berhasil Ditambahkan!");
  // }

  hapusPetugas(docId) async {
    await firestore.collection(userCollection).doc(docId).delete();
    await FirebaseAuth.instance.currentUser!.delete();
  }

  getRole() async {
    var data = await rootBundle.loadString("lib/service/role_model.json");
    var rol = roleModelFromJson(data);
    role = rol.role;
  }

  populateRoleList() {
    roleList.clear();
    for (var item in role) {
      roleList.add(item.name);
    }
  }

  signUpPetugas(context) async {
    await _auth.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    var store = firestore.collection(userCollection).doc();
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('user');
    ref.doc(user!.uid).set({
      'id_user': store.id,
      'nama_petugas': namaPetugasController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'notelp': noTelpController.text,
      'alamat': alamatController.text,
      'role': rolevalue.value
    });
    VxToast.show(context, msg: "Petugas Berhasil Ditambahkan!");
  }

  EditPetugas(docId) async {
    var store = firestore.collection(userCollection).doc(docId).update({
      'nama_petugas': namaPetugasController.text,
      'notelp': noTelpController.text,
      'alamat': alamatController.text,
    });
  }
}
