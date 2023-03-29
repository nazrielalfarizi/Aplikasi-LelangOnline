import 'package:lelang_ujikom/const/const.dart';
import 'package:lelang_ujikom/const/firebase_const.dart';

class StoreService {
  static getBarang() {
    return firestore.collection(barangCollection).snapshots();
  }

  static getPetugas() {
    return firestore
        .collection(userCollection)
        .where('role', whereIn: ['Petugas', 'Admin']).snapshots();
  }

  static getProfile(email) {
    return firestore
        .collection(userCollection)
        .where('email', isEqualTo: email)
        .get();
  }

  static getHistory(email) {
    return firestore
        .collection('history_lelang')
        .where('penawar', isEqualTo: email)
        .get();
  }
}
