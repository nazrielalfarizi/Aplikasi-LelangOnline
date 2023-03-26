import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lelang_ujikom/const/const.dart';
import 'package:lelang_ujikom/controller/login_controller.dart';
import 'package:lelang_ujikom/screen/login_screen.dart';
import 'package:lelang_ujikom/screen/petugas/lelang/tambah_lelang_screen.dart';
import 'package:lelang_ujikom/service/store_service.dart';
import 'package:lelang_ujikom/widgets/loading_indicator.dart';
import 'package:lelang_ujikom/widgets/normal_text.dart';
import 'package:intl/intl.dart' as intl;

import '../../../controller/lelang_controller.dart';
import 'edit_lelang_screen.dart';
import 'lelang_detail_screen.dart';

class LelangScreen extends StatelessWidget {
  const LelangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(lelangController());

    Get.put(LoginController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const TambahLelang());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: boldtext(text: 'Data Lelang', color: darkGrey, size: 16.0),
        actions: [
          Center(
              child: normalText(
                  text: intl.DateFormat('EEE, MMM d,' ' yy')
                      .format(DateTime.now()),
                  color: purpleColor)),
          65.widthBox,
          TextButton(
              onPressed: () async {
                await Get.find<LoginController>().SignOut(context);
                Get.offAll(() => const Login());
              },
              child: boldtext(text: 'Log Out', color: fontGrey, size: 15.0))
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
                          Get.to(() => LelangDetail(data: data[index]));
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
                        trailing: VxPopupMenu(
                          menuBuilder: () => Column(
                            children: List.generate(
                              popupMenuTitles.length,
                              (i) => Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Icon(popupMenuIcons[i]),
                                    10.widthBox,
                                    normalText(
                                        text: popupMenuTitles[i],
                                        color: darkGrey)
                                  ],
                                ).onTap(() {
                                  switch (i) {
                                    case 0:
                                      Get.to(
                                          () => EditLelang(data: data[index]));
                                      // Get.to(() => EditBarang(data: data[index]));
                                      break;
                                    case 1:
                                      // controller.hapusLelang(data[index].id);
                                      // VxToast.show(context,
                                      //     msg: "Barang di Hapus!");
                                      break;
                                  }
                                }),
                              ),
                            ),
                          ).box.white.rounded.width(200).make(),
                          clickType: VxClickType.singleClick,
                          child: const Icon(Icons.more_vert_rounded),
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
