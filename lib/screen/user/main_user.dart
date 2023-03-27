import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelang_ujikom/const/colors.dart';
import 'package:lelang_ujikom/controller/main_admin_controller.dart';
import 'package:lelang_ujikom/controller/main_user_controller.dart';
import 'package:lelang_ujikom/screen/admin/petugas/petugas_screen.dart';
import 'package:lelang_ujikom/screen/login_screen.dart';
import 'package:lelang_ujikom/screen/user/lelang/history_lelang_screen.dart';
import 'package:lelang_ujikom/screen/user/profile/profile_screen.dart';
import 'package:lelang_ujikom/widgets/normal_text.dart';

import 'lelang/lelang_user_screen.dart';

class MainUser extends StatelessWidget {
  const MainUser({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MainUserController());

    var navScreens = [
      const LelangUserScreen(),
      const HistoryLelangScreen(),
      ProfileScreen(),
    ];

    var bottomNavbar = [
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/lelang.png',
            color: Colors.blueAccent,
            width: 24,
          ),
          label: 'Lelang'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/history.png',
            color: Colors.blueAccent,
            width: 24,
          ),
          label: 'History Lelang'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/profile.png',
            color: Colors.blueAccent,
            width: 20,
          ),
          label: 'Profile'),
    ];

    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: boldtext(text: 'Data Barang', color: fontGrey, size: 18.0),
      //   backgroundColor: Colors.white,
      // ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            onTap: (index) {
              controller.navIndex.value = index;
            },
            currentIndex: controller.navIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: darkGrey,
            items: bottomNavbar),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(child: navScreens.elementAt(controller.navIndex.value)),
          ],
        ),
      ),
    );
  }
}
