import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelang_ujikom/const/const.dart';

import '../controller/register_controller.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (controller) {
          controller.view = this;
          return Theme(
            data: ThemeData(
              primaryColor: const Color(0xFF6F35A5),
              scaffoldBackgroundColor: Colors.white,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF6F35A5),
                  shape: const StadiumBorder(),
                  maximumSize: const Size(double.infinity, 56),
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                fillColor: Color(0xFFF1E6FF),
                iconColor: Color(0xFF6F35A5),
                prefixIconColor: Color(0xFF6F35A5),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    imageBackground(),
                    SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: const [
                                Text(
                                  "REGISTER",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 16.0 * 2),
                              ],
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                Expanded(
                                  flex: 8,
                                  child: Form(
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller:
                                              controller.namaUserController,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          cursorColor: const Color(0xFF6F35A5),
                                          onSaved: (email) {},
                                          decoration: const InputDecoration(
                                            hintText: "Nama Pengguna",
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Icon(Icons.person),
                                            ),
                                          ),
                                          onChanged: (value) {},
                                        ),
                                        10.heightBox,
                                        TextFormField(
                                          controller:
                                              controller.noTelpController,
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.next,
                                          cursorColor: const Color(0xFF6F35A5),
                                          onSaved: (email) {},
                                          decoration: const InputDecoration(
                                            hintText: "Nomor Telepon",
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Icon(Icons.phone),
                                            ),
                                          ),
                                          onChanged: (value) {},
                                        ),
                                        10.heightBox,
                                        TextFormField(
                                          controller:
                                              controller.alamatController,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          cursorColor: const Color(0xFF6F35A5),
                                          onSaved: (email) {},
                                          decoration: const InputDecoration(
                                            hintText: "Alamat",
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Icon(Icons.home),
                                            ),
                                          ),
                                          onChanged: (value) {},
                                        ),
                                        10.heightBox,
                                        TextFormField(
                                          controller:
                                              controller.emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textInputAction: TextInputAction.next,
                                          cursorColor: const Color(0xFF6F35A5),
                                          onSaved: (email) {},
                                          decoration: const InputDecoration(
                                            hintText: "Email",
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Icon(Icons.email),
                                            ),
                                          ),
                                          onChanged: (value) {},
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: TextFormField(
                                            controller:
                                                controller.passwordController,
                                            textInputAction:
                                                TextInputAction.done,
                                            obscureText: true,
                                            cursorColor:
                                                const Color(0xFF6F35A5),
                                            decoration: const InputDecoration(
                                              hintText: "Password",
                                              prefixIcon: Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Icon(Icons.lock),
                                              ),
                                            ),
                                            onChanged: (value) {},
                                          ),
                                        ),
                                        const SizedBox(height: 16.0),
                                        Hero(
                                          tag: "register_btn",
                                          child: ElevatedButton(
                                            onPressed: () =>
                                                controller.signUpUser(context),
                                            child: Text(
                                              "REGISTER".toUpperCase(),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16.0),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
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

class imageBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'assets/bg.jpg',
            ),
            fit: BoxFit.cover),
      ),
    );
  }
}
