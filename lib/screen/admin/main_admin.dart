import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelang_ujikom/const/colors.dart';
import 'package:lelang_ujikom/controller/main_admin_controller.dart';
import 'package:lelang_ujikom/screen/admin/petugas/petugas_screen.dart';
import 'package:lelang_ujikom/screen/login_screen.dart';
import 'package:lelang_ujikom/screen/petugas/lelang/lelang_screen.dart';
import 'package:lelang_ujikom/widgets/normal_text.dart';

import 'barang/barang_screen.dart';

class MainAdmin extends StatelessWidget {
  const MainAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MainAdminController());

    var navScreens = [
      const BarangView(),
      const PetugasScreen(),
      const LelangScreen()
    ];

    var bottomNavbar = [
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/products.png',
            color: Colors.blueAccent,
            width: 24,
          ),
          label: 'Barang'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/profile.png',
            color: Colors.blueAccent,
            width: 24,
          ),
          label: 'Petugas'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/lelang.png',
            color: Colors.blueAccent,
            width: 24,
          ),
          label: 'Lelang'),
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
