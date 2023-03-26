import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lelang_ujikom/const/const.dart';
import 'package:lelang_ujikom/controller/barang_controller.dart';
import 'package:lelang_ujikom/screen/admin/barang/barang_screen.dart';

import '../../../components/product_image.dart';
import '../../../widgets/loading_indicator.dart';
import '../../../widgets/normal_text.dart';

class AddBarang extends StatelessWidget {
  const AddBarang({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BarangController>(
        init: BarangController(),
        builder: (controller) {
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
              title: boldtext(
                  text: "Tambah Data Barang", color: fontGrey, size: 16.0),
              actions: [
                controller.isLoading.value
                    ? LoadingIndicator()
                    : TextButton(
                        onPressed: () async {
                          controller.isLoading(true);
                          await controller.uploadImage();
                          await controller.uploadBarang(context);
                          Get.back();
                        },
                        child: boldtext(
                            text: "Simpan", color: Colors.greenAccent[700]))
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                        controller: controller.namaBarangController,
                        decoration: const InputDecoration(
                          labelText: "Nama Barang",
                          hintText: "Nama Barang",
                        )),
                    10.heightBox,
                    TextFormField(
                      readOnly: true,
                      controller: controller.TanggalBarangController,
                      decoration: const InputDecoration(
                        labelText: 'Tanggal Barang',
                      ),
                      onTap: () async {
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2015),
                          lastDate: DateTime(2025),
                        ).then((selectedDate) {
                          if (selectedDate != null) {
                            controller.TanggalBarangController.text =
                                DateFormat('yyyy-MM-dd').format(selectedDate);
                          }
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter date.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controller.HargaAwalController,
                      decoration: const InputDecoration(
                          labelText: "Harga Awal", hintText: "Harga Awal"),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: controller.DeskripsiBarangController,
                      maxLines: 7,
                      maxLength: 1500,
                      decoration: const InputDecoration(
                          labelText: "Deskripsi Barang",
                          hintText: "Deskripsi Barang"),
                    ),
                    10.heightBox,
                    normalText(text: "Pilih Gambar Barang", color: fontGrey),
                    5.heightBox,
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          2,
                          (index) => controller.barangImageList[index] != null
                              ? Image.file(
                                  controller.barangImageList[index],
                                  width: 120,
                                ).onTap(() {
                                  controller.pickImage(index, context);
                                })
                              : GambarBarang(Label: "${index + 1}").onTap(() {
                                  controller.pickImage(index, context);
                                }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
