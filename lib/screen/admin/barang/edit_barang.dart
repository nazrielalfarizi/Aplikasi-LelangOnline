import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lelang_ujikom/const/const.dart';
import 'package:lelang_ujikom/controller/petugas_controller.dart';
import 'package:lelang_ujikom/screen/admin/main_admin.dart';
import 'package:lelang_ujikom/screen/admin/petugas/petugas_screen.dart';

import '../../../components/product_image.dart';
import '../../../const/colors.dart';
import '../../../controller/barang_controller.dart';
import '../../../widgets/loading_indicator.dart';
import '../../../widgets/normal_text.dart';

class EditBarang extends StatelessWidget {
  final Map? item;
  // final Map? barang;
  EditBarang({super.key, this.item});

  var controller = Get.find<BarangController>();

  @override
  Widget build(BuildContext context) {
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
          title:
              boldtext(text: "Edit Data Barang", color: fontGrey, size: 16.0),
          actions: [
            controller.isLoading.value
                ? LoadingIndicator()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          await controller.EditBarang(item!['id']);
                          Get.back();
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
            //       await controller.EditBarang(item!['id']);
            //       Get.back();
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
                    controller: controller.namaBarangController
                      ..text = item!['nama_barang'],
                    decoration: const InputDecoration(
                      labelText: "Nama Barang",
                      hintText: "Nama Barang",
                    )),
                10.heightBox,
                TextFormField(
                  readOnly: true,
                  controller: controller.TanggalBarangController
                    ..text = item!['tanggal'],
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Barang',
                  ),
                  onTap: () async {
                    await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2015),
                      lastDate: DateTime(2025),
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        controller.TanggalBarangController.text =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                      }
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter date.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.HargaAwalController
                    ..text = item!['harga_awal'],
                  decoration: const InputDecoration(
                      labelText: "Harga Awal", hintText: "Harga Awal"),
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  controller: controller.DeskripsiBarangController
                    ..text = item!['deskripsi_barang'],
                  maxLines: 7,
                  maxLength: 1500,
                  decoration: const InputDecoration(
                      labelText: "Deskripsi Barang",
                      hintText: "Deskripsi Barang"),
                ),
                10.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
