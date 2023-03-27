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

class HistoryLelangScreen extends StatelessWidget {
  const HistoryLelangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PetugasController());

    Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: boldtext(text: 'History Lelang', color: darkGrey, size: 16.0),
        actions: [
          Center(
              child: normalText(
                  text: intl.DateFormat('EEE, MMM d,' ' yy')
                      .format(DateTime.now()),
                  color: purpleColor)),
          45.widthBox,
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
        stream: StoreService.getPetugas(),
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
                        title: boldtext(
                            text: "${data[index]['nama_petugas']}",
                            color: fontGrey,
                            size: 20.0),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            normalText(
                              text: "${data[index]['email']}",
                              color: Colors.blue,
                            ),
                            normalText(
                              text:
                                  "Password : " + "${data[index]['password']}",
                              color: Colors.blue,
                            ),
                            normalText(
                              text: "${data[index]['notelp']}",
                              color: darkGrey,
                            ),
                            normalText(
                              text: "${data[index]['alamat']}",
                              color: darkGrey,
                            )
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
