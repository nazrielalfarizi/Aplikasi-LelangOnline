import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lelang_ujikom/const/const.dart';
import 'package:lelang_ujikom/controller/petugas_controller.dart';
import 'package:lelang_ujikom/screen/admin/main_admin.dart';
import 'package:lelang_ujikom/screen/admin/petugas/petugas_screen.dart';

import '../../../components/role_dropdown.dart';
import '../../../widgets/loading_indicator.dart';
import '../../../widgets/normal_text.dart';

class EditPetugas extends StatelessWidget {
  final Map? item;
  EditPetugas({super.key, this.item});
  var controller = Get.find<PetugasController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
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
          title:
              boldtext(text: "Edit Data Petugas", color: fontGrey, size: 16.0),
          actions: [
            controller.isLoading.value
                ? LoadingIndicator()
                : TextButton(
                    onPressed: () async {
                      await controller.EditPetugas(item!['id']);
                      Get.to(MainAdmin());
                    },
                    child: boldtext(
                        text: "Simpan", color: Colors.greenAccent[700]))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                TextFormField(
                    controller: controller.namaPetugasController
                      ..text = item!['nama_petugas'],
                    decoration: const InputDecoration(
                      labelText: "Nama Petugas",
                      hintText: "Nama Petugas",
                    )),
                10.heightBox,
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.noTelpController
                    ..text = item!['notelp'],
                  decoration: const InputDecoration(
                      labelText: "Nomor Telepon", hintText: "Nomor Telepon"),
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  controller: controller.alamatController
                    ..text = item!['alamat'],
                  maxLines: 2,
                  maxLength: 200,
                  decoration: const InputDecoration(
                      labelText: "Alamat", hintText: "Alamat"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
