import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lelang_ujikom/const/colors.dart';
import 'package:lelang_ujikom/const/const.dart';
import 'package:lelang_ujikom/controller/lelang_controller.dart';
import 'package:lelang_ujikom/screen/petugas/main_petugas.dart';
import 'package:lelang_ujikom/widgets/normal_text.dart';

class BarangDetailPetugas extends StatelessWidget {
  final dynamic data;
  final String? barangId;
  final String? hargaAwal;
  final String? namabarang;
  final String? deskripsi;
  final String? image;
  const BarangDetailPetugas(
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
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Buka Lelang'),
                            content: TextFormField(
                              readOnly: true,
                              controller: controller.TanggalAkhirController,
                              decoration: const InputDecoration(
                                labelText: 'Tanggal Lelang Berakhir',
                              ),
                              onTap: () async {
                                await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2015),
                                  lastDate: DateTime(2025),
                                ).then((selectedDate) {
                                  if (selectedDate != null) {
                                    controller.TanggalAkhirController.text =
                                        DateFormat('yyyy-MM-dd')
                                            .format(selectedDate);
                                  }
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Mohon Masukan Tanggal.';
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

                                    await controller.bukaLelang(context,
                                        barangId: data['barang_id'],
                                        namaBarang: data['nama_barang'],
                                        hargaAwal: data['harga_awal'],
                                        deskripsi: data['deskripsi_barang'],
                                        image: data['barang_image']);
                                    await controller.UpdateStatus(
                                        barangId: data['id_barang']);
                                    Get.to(MainPetugas());
                                    VxToast.show(context,
                                        msg: "Barang berhasil Dibuka!");
                                  },
                                  child: const Text("Open"))
                            ],
                          );
                        });
                  },
                  child: const Text("Buka Lelang"),
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
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldtext(
                      text: "${data['nama_barang']}",
                      color: fontGrey,
                      size: 30.0),
                  10.heightBox,
                  normalText(
                      text: "Di Upload :" + " ${data['tanggal']}",
                      color: fontGrey,
                      size: 18.0),
                  10.heightBox,
                  normalText(
                      text: "Harga Awal :" + "  Rp." + "${data['harga_awal']}",
                      color: Colors.redAccent[700],
                      size: 18.0),
                  10.heightBox,
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
