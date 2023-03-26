import 'package:get/get.dart';
import 'package:lelang_ujikom/const/const.dart';
import 'package:lelang_ujikom/screen/admin/main_admin.dart';
import 'package:lelang_ujikom/screen/user/profile/profile_screen.dart';

import '../../../controller/profile_controller.dart';
import '../../../widgets/loading_indicator.dart';
import '../../../widgets/normal_text.dart';

class EditProfile extends StatefulWidget {
  final String? nama;
  final String? notelp;
  final String? alamat;
  EditProfile({super.key, this.nama, this.notelp, this.alamat});

  @override
  State<EditProfile> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfile> {
  var controller = Get.find<ProfileControler>();

  @override
  void initState() {
    controller.namaController.text = widget.nama!;
    controller.noTelpController.text = widget.notelp!;
    controller.AlamatController.text = widget.alamat!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: boldtext(text: "Edit Data", color: fontGrey, size: 16.0),
        actions: [
          TextButton(
              onPressed: () async {
                await controller.changeAuthPassword();

                await controller.updateProfile(
                  nama: controller.namaController.text,
                  alamat: controller.AlamatController.text,
                  notelp: controller.noTelpController.text,
                );
                VxToast.show(context, msg: "Data di Update!");
                Get.to(ProfileScreen());
              },
              child: boldtext(text: "Edit", color: Colors.greenAccent[700]))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              TextFormField(
                  controller: controller.namaController,
                  decoration: const InputDecoration(
                    labelText: "Nama",
                    hintText: "Nama",
                  )),
              10.heightBox,
              TextFormField(
                keyboardType: TextInputType.number,
                controller: controller.noTelpController,
                decoration: const InputDecoration(
                    labelText: "Nomor Telepon", hintText: "Nomor Telepon"),
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                controller: controller.AlamatController,
                maxLines: 2,
                maxLength: 200,
                decoration: const InputDecoration(
                    labelText: "Alamat", hintText: "Alamat"),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: boldtext(text: "Ganti Password", color: fontGrey),
              ),
              TextFormField(
                obscureText: true,
                controller: controller.changePassController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: "Password Baru"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
