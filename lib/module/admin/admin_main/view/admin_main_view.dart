import 'package:flutter/material.dart';
import '../controller/admin_main_controller.dart';
import 'package:lelang_ujikom/core.dart';
import 'package:get/get.dart';

class AdminMainView extends StatelessWidget {
  const AdminMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminMainController>(
      init: AdminMainController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("AdminMain"),
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