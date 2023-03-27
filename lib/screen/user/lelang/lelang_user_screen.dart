import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lelang_ujikom/const/const.dart';
import 'package:lelang_ujikom/const/firebase_const.dart';
import 'package:lelang_ujikom/controller/login_controller.dart';
import 'package:lelang_ujikom/screen/admin/barang/barang_detail_screen.dart';
import 'package:lelang_ujikom/screen/login_screen.dart';
import 'package:lelang_ujikom/service/store_service.dart';
import 'package:lelang_ujikom/widgets/loading_indicator.dart';
import 'package:lelang_ujikom/widgets/normal_text.dart';
import 'package:intl/intl.dart' as intl;

import '../../../controller/barang_controller.dart';

class LelangUserScreen extends StatelessWidget {
  const LelangUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(BarangController());

    Get.put(LoginController());
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Get.to(() => const TambahBarang());
      //   },
      //   child: const Icon(Icons.add),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: boldtext(text: 'Lelang', color: darkGrey, size: 16.0),
        actions: [
          Center(
              child: normalText(
                  text: intl.DateFormat('EEE, MMM d,' ' yy')
                      .format(DateTime.now()),
                  color: purpleColor)),
          65.widthBox,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () async {
                  await Get.find<LoginController>().SignOut(context);
                  Get.offAll(() => const Login());
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  primary: Colors.red,
                  onPrimary: Colors.white,
                ),
                child: boldtext(text: 'Log Out', color: white, size: 15.0)),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: StoreService.getBarang(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return LoadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    data.length,
                    (index) => Card(
                      elevation: 5,
                      child: ListTile(
                        onTap: () {
                          Get.to(() => BarangDetail(data: data[index]));
                        },
                        leading: Image.network(
                          data[index]["barang_image"][0],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        title: boldtext(
                            text: "${data[index]['nama_barang']}",
                            color: fontGrey,
                            size: 20.0),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            normalText(
                              text: "Rp." + "${data[index]['harga_awal']}",
                              color: Colors.redAccent[700],
                            ),
                            normalText(
                              text: "Dibuka: " + "${data[index]['tanggal']}",
                              color: darkGrey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
