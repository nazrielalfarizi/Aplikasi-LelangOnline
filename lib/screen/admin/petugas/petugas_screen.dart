import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lelang_ujikom/const/const.dart';
import 'package:lelang_ujikom/screen/admin/petugas/tambah_petugas.dart';
import '../../../controller/login_controller.dart';
import '../../../controller/petugas_controller.dart';
import '../../../service/store_service.dart';
import '../../../widgets/loading_indicator.dart';
import '../../../widgets/normal_text.dart';
import '../../login_screen.dart';
import 'package:intl/intl.dart' as intl;

import 'edit_petugas_screen.dart';

class PetugasScreen extends StatelessWidget {
  const PetugasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PetugasController>(
        init: PetugasController(),
        builder: (controller) {
          controller.view = this;

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.to(() => const TambahPetugas());
              },
              child: const Icon(Icons.add),
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title:
                  boldtext(text: 'Data Petugas', color: darkGrey, size: 16.0),
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
                    child:
                        boldtext(text: 'Log Out', color: fontGrey, size: 15.0))
              ],
            ),
            body: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("user")
                          .where('role',
                              whereIn: ['Petugas', 'Admin']).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) return const Text("Error");
                        if (snapshot.data == null) return Container();
                        if (snapshot.data!.docs.isEmpty) {
                          return const Text("No Data");
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
                                child: ListTile(
                                  title: boldtext(
                                      text: item['nama_petugas'],
                                      color: fontGrey,
                                      size: 20.0),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      normalText(
                                        text: item['email'],
                                        color: Colors.blue,
                                      ),
                                      normalText(
                                        text: "Password : " + item['password'],
                                        color: Colors.blue,
                                      ),
                                      normalText(
                                        text: item['notelp'],
                                        color: darkGrey,
                                      ),
                                      normalText(
                                        text: item['alamat'],
                                        color: darkGrey,
                                      ),
                                      normalText(
                                        text: "Role : " + item['role'],
                                        color: darkGrey,
                                      )
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
                                                Get.to(() => EditPetugas(
                                                      item: item,
                                                    ));

                                                break;
                                              case 1:
                                                controller
                                                    .hapusPetugas(item['id']);
                                                VxToast.show(context,
                                                    msg: "Petugas di Hapus!");
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
