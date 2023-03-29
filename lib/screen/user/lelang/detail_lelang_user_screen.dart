import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:lelang_ujikom/const/colors.dart';
import 'package:lelang_ujikom/const/const.dart';
import 'package:lelang_ujikom/screen/user/main_user.dart';
import 'package:lelang_ujikom/widgets/normal_text.dart';

import '../../../controller/lelang_controller.dart';

class LelangUserDetail extends StatelessWidget {
  final dynamic data;
  final String? barangId;
  final String? hargaAwal;
  final String? namabarang;
  final String? deskripsi;
  final String? image;
  const LelangUserDetail(
      {super.key,
      this.barangId,
      this.hargaAwal,
      this.namabarang,
      this.deskripsi,
      this.image,
      this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(lelangController());
    return Scaffold(
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
        title: boldtext(text: "Detail Barang", color: fontGrey, size: 16.0),
      ),
      bottomNavigationBar: SizedBox(
          height: 60,
          width: context.screenWidth,
          child: data['status'] == 'Dilelang'
              ? SizedBox()
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Tawar Barang'),
                            content: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: controller.hargaAkhirController,
                              decoration: const InputDecoration(
                                labelText: 'Tawaran Anda',
                              ),
                              onTap: () async {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Mohon Masukan Harga diatas Harga akhir.';
                                }
                                return null;
                              },
                            ),
                            actions: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel")),
                              ElevatedButton(
                                  onPressed: () async {
                                    // Panggil fungsi bukaLelang dengan parameter barangId dan hargaAwal

                                    await controller.AddToHistory(context,
                                        lelangId: data['lelang_id'],
                                        namaBarang: data['nama_barang'],
                                        hargaAkhir: data['harga_akhir'],
                                        image: data['barang_image']);
                                    await controller.TawarBarang(
                                        lelangId: data['lelang_id']);
                                    Get.to(MainUser());
                                    VxToast.show(context,
                                        msg: "Tawaran berhasil!");
                                  },
                                  child: const Text("Tawar"))
                            ],
                          );
                        });
                  },
                  child: const Text("Tawar Barang"),
                )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
                autoPlay: true,
                height: 350,
                itemCount: data['barang_image'].length,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                itemBuilder: (context, index) {
                  return Image.network(
                    data['barang_image'][index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldtext(
                      text: "${data['nama_barang']}",
                      color: fontGrey,
                      size: 30.0),
                  5.heightBox,
                  normalText(
                      text: "Dibuka :" + " ${data['tanggal_mulai']}",
                      color: fontGrey,
                      size: 16.0),
                  normalText(
                      text: "Ditutup :" + " ${data['tanggal_berakhir']}",
                      color: fontGrey,
                      size: 16.0),
                  10.heightBox,
                  normalText(
                      text: "Harga Awal :" + "  Rp." + "${data['harga_awal']}",
                      color: Colors.green,
                      size: 18.0),
                  normalText(
                      text:
                          "Harga Akhir :" + "  Rp." + "${data['harga_akhir']}",
                      color: Colors.red,
                      size: 18.0),
                  normalText(
                      text: "Penawar :" + "${data['penawar']}",
                      color: fontGrey,
                      size: 18.0),
                  5.heightBox,
                  boldtext(text: "Deskripsi", color: fontGrey, size: 20.0),
                  5.heightBox,
                  normalText(
                      text: "${data['deskripsi_barang']}",
                      color: fontGrey,
                      size: 16.0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
