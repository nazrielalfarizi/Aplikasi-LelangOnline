import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelang_ujikom/const/const.dart';
import 'package:lelang_ujikom/controller/petugas_controller.dart';
import 'package:lelang_ujikom/screen/admin/main_admin.dart';
import 'package:lelang_ujikom/screen/admin/petugas/petugas_screen.dart';

import '../../../components/role_dropdown.dart';
import '../../../const/colors.dart';
import '../../../controller/barang_controller.dart';
import '../../../widgets/loading_indicator.dart';
import '../../../widgets/normal_text.dart';

class TambahPetugas extends StatelessWidget {
  const TambahPetugas({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PetugasController());

    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: (const Icon(
              Icons.arrow_back,
              color: darkGrey,
            )),
          ),
          title: boldtext(
              text: "Tambah Data Petugas", color: fontGrey, size: 16.0),
          actions: [
            controller.isLoading.value
                ? LoadingIndicator()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          await controller.signUpPetugas(context);
                          Get.to(MainAdmin());
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          primary: Colors.green,
                          onPrimary: Colors.white,
                        ),
                        child:
                            boldtext(text: 'Save', color: white, size: 15.0)),
                  ),
            // : TextButton(
            //     onPressed: () async {
            //       await controller.signUpPetugas(context);
            //       Get.to(MainAdmin());
            //     },
            //     child: boldtext(
            //         text: "Simpan", color: Colors.greenAccent[700]))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                TextFormField(
                    controller: controller.namaPetugasController,
                    decoration: const InputDecoration(
                      labelText: "Nama Petugas",
                      hintText: "Nama Petugas",
                    )),
                10.heightBox,
                TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                        labelText: "Email", hintText: "Email"),
                    validator: (value) =>
                        value!.isEmpty ? "Email Tidak Boleh Kosong" : null,
                    onChanged: (value) {}),
                TextFormField(
                  controller: controller.passwordController,
                  decoration: const InputDecoration(
                      labelText: "Password", hintText: "Password"),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.noTelpController,
                  decoration: const InputDecoration(
                      labelText: "Nomor Telepon", hintText: "Nomor Telepon"),
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  controller: controller.alamatController,
                  maxLines: 2,
                  maxLength: 200,
                  decoration: const InputDecoration(
                      labelText: "Alamat", hintText: "Alamat"),
                ),
                roleDropdown("Role", controller.roleList, controller.rolevalue,
                    controller)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
