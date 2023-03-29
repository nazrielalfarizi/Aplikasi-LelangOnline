import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelang_ujikom/const/const.dart';

import 'package:lelang_ujikom/widgets/normal_text.dart';


class LelangDetail extends StatelessWidget {
  final dynamic data;
  const LelangDetail({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // final invoice = Invoice(

          // );

          // final pdfFile = await PdfInvoiceApi.generate(invoice);

          // FileHandleApi.openFile(pdfFile);
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(
          Icons.assignment,
          color: white,
        ),
      ),
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
        title: boldtext(text: "Detail Lelang", color: fontGrey, size: 16.0),
      ),
      // bottomNavigationBar: SizedBox(
      //   height: 60,
      //   width: context.screenWidth,
      //   child: ElevatedButton(
      //     style: ElevatedButton.styleFrom(
      //       backgroundColor: Colors.green,
      //     ),
      //     onPressed: () {},
      //     child: const Text("Save"),
      //   ),
      // ),
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
