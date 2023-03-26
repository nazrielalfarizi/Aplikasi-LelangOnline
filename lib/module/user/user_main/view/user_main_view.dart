import 'package:flutter/material.dart';
import '../controller/user_main_controller.dart';
import 'package:lelang_ujikom/core.dart';
import 'package:get/get.dart';

class UserMainView extends StatelessWidget {
  const UserMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserMainController>(
      init: UserMainController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("UserMain"),
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