import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lelang_ujikom/screen/admin/main_admin.dart';
import 'package:lelang_ujikom/screen/login_screen.dart';

import '../const/const.dart';
import '../const/firebase_const.dart';
import '../screen/register_screen.dart';

class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var namaUserController = TextEditingController();
  var noTelpController = TextEditingController();
  var alamatController = TextEditingController();
  Register? view;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  signUpUser(context) async {
    await _auth.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    var store = firestore.collection(userCollection).doc();
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('user');
    ref.doc().set({
      'id_user': store.id,
      'nama_user': namaUserController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'notelp': noTelpController.text,
      'alamat': alamatController.text,
      'role': 'Public'
    });
    Get.off(const Login());
    VxToast.show(context, msg: "Berhasil Register!, Silahkan Login ");
  }
}
