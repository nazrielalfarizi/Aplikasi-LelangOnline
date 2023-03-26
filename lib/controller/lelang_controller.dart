import 'package:get/get.dart';

import '../const/const.dart';
import '../const/firebase_const.dart';

class lelangController extends GetxController {
  var TanggalAkhirController = TextEditingController();

  BukaLelang(docId) async {
    await firestore.collection(userCollection).doc(docId).set({
      'tanggal_berakhir': TanggalAkhirController.text,
      'status_lelang': 'Di Buka',
    });
  }
}
