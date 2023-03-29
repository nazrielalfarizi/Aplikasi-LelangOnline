import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../const/const.dart';
import '../screen/admin/main_admin.dart';
import '../screen/login_screen.dart';
import '../screen/petugas/main_petugas.dart';
import '../screen/register_screen.dart';
import '../screen/user/main_user.dart';

class LoginController extends GetxController {
  final _auth = FirebaseAuth.instance;
  Login? view;

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

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

  RegisterPage() {
    Get.off(const Register());
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == 'Admin') {
          Get.off(const MainAdmin());
        } else if (documentSnapshot.exists) {
          if (documentSnapshot.get('role') == 'Petugas') {
            Get.off(const MainPetugas());
          }
        } else {}
      } else {
        Get.off(MainUser());
      }
    });
  }

  void signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      route();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  SignOut(context) async {
    try {
      await _auth.signOut();
    } on Exception catch (err) {
      print(err);
    }
  }
}
