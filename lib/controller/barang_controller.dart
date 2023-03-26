import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lelang_ujikom/const/const.dart';
import 'package:path/path.dart';

import '../const/firebase_const.dart';
import '../screen/admin/barang/barang_screen.dart';
import '../screen/admin/barang/tambah_barang.dart';

class BarangController extends GetxController {
  BarangView? view;
  var isLoading = false.obs;

  var id = TextEditingController();
  var namaBarangController = TextEditingController();
  var TanggalBarangController = TextEditingController();
  var HargaAwalController = TextEditingController();
  var DeskripsiBarangController = TextEditingController();

  var barangImageLinks = [];
  var barangImageList = RxList<dynamic>.generate(2, (index) => null);

  File? img;

  pickImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      } else {
        barangImageList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImage() async {
    barangImageLinks.clear();
    for (var item in barangImageList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination = 'images/barang/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        barangImageLinks.add(n);
      }
    }
  }

  uploadBarang(context) async {
    var store = firestore.collection(barangCollection).doc();
    await store.set({
      'id_barang': store.id,
      'nama_barang': namaBarangController.text,
      'tanggal': TanggalBarangController.text,
      'harga_awal': HargaAwalController.text,
      'deskripsi_barang': DeskripsiBarangController.text,
      'barang_image': FieldValue.arrayUnion(barangImageLinks)
    });
    isLoading(false);

    VxToast.show(context, msg: "Barang Berhasil Ditambahkan!");
  }

  hapusBarang(docId) async {
    await firestore.collection(barangCollection).doc(docId).delete();
  }

  EditBarang(docId) async {
    var store = firestore.collection(barangCollection).doc(docId).update({
      'nama_barang': namaBarangController.text,
      'tanggal': TanggalBarangController.text,
      'harga_awal': HargaAwalController.text,
      'deskripsi_barang': DeskripsiBarangController.text,
    });
  }
}
