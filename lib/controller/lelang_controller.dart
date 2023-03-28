import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lelang_ujikom/screen/petugas/lelang/lelang_screen.dart';

import '../const/const.dart';
import '../const/firebase_const.dart';

class lelangController extends GetxController {
  LelangScreen? view;
  var TanggalAkhirController = TextEditingController();

  bukaLelang(context,
      {required barangId,
      required hargaAwal,
      required namaBarang,
      required deskripsi,
      required image}) async {
    // Get data barang
    var barangRef =
        FirebaseFirestore.instance.collection('barang').doc(barangId);
    var barangDoc = await barangRef.get();
    var barangData = barangDoc.data();

    // Get tanggal lelang berakhir dari controller
    var tanggalLelangBerakhir = TanggalAkhirController.text;

    // Buat document data lelang baru
    String? userEmail = FirebaseAuth.instance.currentUser!.email;
    var lelangRef = FirebaseFirestore.instance.collection('lelang').doc();
    var lelangData = {
      'barang': barangRef,
      'lelang_id': lelangRef.id,
      'nama_barang': namaBarang,
      'deskripsi_barang': deskripsi,
      'barang_image': image,
      'harga_awal': hargaAwal,
      'harga_akhir': hargaAwal,
      'penawar': '',
      'petugas': userEmail,
      'tanggal_mulai':
          DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),
      'tanggal_berakhir': DateFormat('dd/MM/yyyy')
          .format(DateTime.parse(tanggalLelangBerakhir))
          .toString(),
      'status': 'Dibuka',
    };

    // Masukkan data lelang ke dalam document baru
    await lelangRef.set(lelangData);
  }

  UpdateStatus({required barangId}) async {
    var store = firestore
        .collection(barangCollection)
        .doc(barangId)
        .update({'status': 'Dilelang'});
  }
}
