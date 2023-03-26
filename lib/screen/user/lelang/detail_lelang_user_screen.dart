import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelang_ujikom/const/colors.dart';
import 'package:lelang_ujikom/const/const.dart';
import 'package:lelang_ujikom/widgets/normal_text.dart';

class LelangUserDetail extends StatelessWidget {
  final dynamic data;
  const LelangUserDetail({super.key, this.data});

  @override
  Widget build(BuildContext context) {
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
                  boldtext(text: "${data['nama_barang']}", color: fontGrey, size: 30.0),
                  10.heightBox,
                  normalText(
                      text: "Dibuka :" + " ${data['tanggal']}",
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
                      text: "${data['deskripsi_barang']}", color: fontGrey, size: 16.0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
