import 'package:flutter/material.dart';
import '../controller/petugas_main_controller.dart';
import 'package:lelang_ujikom/core.dart';
import 'package:get/get.dart';

class PetugasMainView extends StatelessWidget {
  const PetugasMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PetugasMainController>(
      init: PetugasMainController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("PetugasMain"),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: const [],
              ),
            ),
          ),
        );
      },
    );
  }
}