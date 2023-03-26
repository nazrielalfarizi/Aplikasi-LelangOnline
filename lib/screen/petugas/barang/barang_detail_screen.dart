import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lelang_ujikom/const/colors.dart';
import 'package:lelang_ujikom/const/const.dart';
import 'package:lelang_ujikom/controller/lelang_controller.dart';
import 'package:lelang_ujikom/widgets/normal_text.dart';

class BarangDetailPetugas extends StatelessWidget {
  final String? id;
  final dynamic data;
  const BarangDetailPetugas({super.key, this.data, this.id});

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
        child: ElevatedButton(
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
                                DateFormat('yyyy-MM-dd').format(selectedDate);
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
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel")),
                      ElevatedButton(
                          onPressed: () {
                          
                          },
                          child: const Text("Update"))
                    ],
                  );
                });
          },
          child: const Text("Buka Lelang"),
        ),
      ),
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
                  10.heightBox,
                  normalText(
                      text: "${data['deskripsi_barang']}",
                      color: fontGrey,
                      size: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
