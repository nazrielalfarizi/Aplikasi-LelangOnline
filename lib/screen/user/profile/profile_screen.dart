import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelang_ujikom/const/colors.dart';
import 'package:lelang_ujikom/const/const.dart';
import 'package:lelang_ujikom/const/firebase_const.dart';
import 'package:lelang_ujikom/controller/profile_controller.dart';
import 'package:lelang_ujikom/screen/user/profile/edit_profile.dart';
import 'package:lelang_ujikom/service/store_service.dart';
import 'package:lelang_ujikom/widgets/loading_indicator.dart';
import 'package:lelang_ujikom/widgets/normal_text.dart';

import '../../../controller/login_controller.dart';
import '../../login_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  String? userEmail = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileControler());
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: boldtext(text: "Profile", size: 16.0, color: darkGrey),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(() => EditProfile(
                          nama: controller.snapshotData['nama_user'],
                          notelp: controller.snapshotData['notelp'],
                          alamat: controller.snapshotData['alamat'],
                        ));
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: darkGrey,
                  )),
              10.widthBox,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () async {
                      await Get.find<LoginController>().SignOut(context);
                      Get.offAll(() => const Login());
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      primary: Colors.red,
                      onPrimary: Colors.white,
                    ),
                    child: boldtext(text: 'Log Out', color: white, size: 15.0)),
              ),
            ]),
        body: FutureBuilder(
          future: StoreService.getProfile(userEmail),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return LoadingIndicator();
            } else {
              controller.snapshotData = snapshot.data!.docs[0];
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Image.asset(
                      "assets/icons/profile.png",
                      width: 150,
                      color: fontGrey,
                    ).box.roundedFull.clip(Clip.antiAlias).make(),
                    10.heightBox,
                    boldtext(
                        text: "${controller.snapshotData['nama_user']}",
                        color: darkGrey,
                        size: 25.0),
                    10.heightBox,
                    Text("Alamat Email :"),
                    5.heightBox,
                    boldtext(
                        text: "${controller.snapshotData['email']}",
                        color: Colors.blueAccent,
                        size: 18.0),
                    10.heightBox,
                    Text("Alamat :"),
                    5.heightBox,
                    normalText(
                        text: "${controller.snapshotData['alamat']}",
                        color: fontGrey,
                        size: 18.0),
                    10.heightBox,
                    Text("Nomor Telepon :"),
                    5.heightBox,
                    normalText(
                        text: "${controller.snapshotData['notelp']}",
                        color: fontGrey,
                        size: 18.0),
                  ]),
                ),
              );
            }
          },
        ));
  }
}
