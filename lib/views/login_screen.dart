import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:todolist/constants/constants.dart';
import 'package:todolist/controller/auth_controller.dart';

import 'package:todolist/views/register.dart';
import 'package:todolist/views/todo_home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emalcontroller = TextEditingController();
  TextEditingController _passwordcontrolller = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AuthController _authcontroller = Get.find<AuthController>();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/spash.png')),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration:
                      Get.isDarkMode ? txtDecorationDark : txtDecoration,
                  child: TextFormField(
                    controller: _emalcontroller,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Enter Email"),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration:
                      Get.isDarkMode ? txtDecorationDark : txtDecoration,
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _passwordcontrolller,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter password",
                    ),
                  ),
                ),
                TextButton(onPressed: () {}, child: Text("Forgot Password?")),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      User? user =
                          await _authcontroller.signiUpwithemailandpassword(
                              _emalcontroller.text, _passwordcontrolller.text);

                      if (user != null) {
                        Get.offAll(TodoHome());
                      }
                    }
                  },
                  child: Text("CONTINUE"),
                ),
                Container(
                  width: 250,
                  child: Row(
                    children: [
                      Text("Dont have an account?"),
                      TextButton(
                          onPressed: () {
                            Get.to(Register());
                          },
                          child: Text("Register"))
                    ],
                  ),
                )
              ]),
        ),
      )),
    );
  }
}
