import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lelang_ujikom/const/const.dart';
import 'package:lelang_ujikom/controller/login_controller.dart';
import 'package:lelang_ujikom/screen/login_screen.dart';
import 'package:lelang_ujikom/widgets/normal_text.dart';
import 'package:intl/intl.dart' as intl;

import '../../../controller/lelang_controller.dart';
import 'detail_lelang_user_screen.dart';

class LelangUserScreen extends StatelessWidget {
  const LelangUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<lelangController>(
        init: lelangController(),
        builder: (controller) {
          controller.viewUser = this;

          return Scaffold(
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
                      child:
                          boldtext(text: 'Log Out', color: white, size: 15.0)),
                ),
              ],
            ),
            body: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("lelang")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) return const Text("Error");
                        if (snapshot.data == null) return Container();
                        if (snapshot.data!.docs.isEmpty) {
                          return Center(
                              child:
                                  const Text("Tidak ada barang yang dilelang"));
                        }
                        final data = snapshot.data!;
                        return ListView.builder(
                          itemCount: data.docs.length,
                          padding: EdgeInsets.zero,
                          clipBehavior: Clip.none,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> item = (data.docs[index].data()
                                as Map<String, dynamic>);
                            item["id"] = data.docs[index].id;
                            final DocumentSnapshot records =
                                snapshot.data!.docs[index];
                            return InkWell(
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => LelangUserDetail(data: item));
                                  },
                                  leading: Image.network(
                                    item["barang_image"][0],
                                  ),
                                  title: boldtext(
                                      text: item["nama_barang"],
                                      color: fontGrey,
                                      size: 20.0),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      normalText(
                                        text: "Harga Akhir : " +
                                            item["harga_akhir"],
                                        color: Colors.redAccent[700],
                                      ),
                                      normalText(
                                        text:
                                            "Dibuka : " + item["tanggal_mulai"],
                                        color: darkGrey,
                                      ),
                                      normalText(
                                        text: "Ditutip : " +
                                            item["tanggal_berakhir"],
                                        color: darkGrey,
                                      ),
                                      item['status'] == 'Dibuka'
                                          ? normalText(
                                              text: item['status'],
                                              color: Colors.green)
                                          : normalText(
                                              text: item['status'],
                                              color: Colors.redAccent[700])
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
