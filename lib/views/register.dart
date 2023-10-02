import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'package:todolist/constants/constants.dart';
import 'package:todolist/views/login_screen.dart';

import '../controller/auth_controller.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _usenameController = TextEditingController();
  TextEditingController _emalcontroller = TextEditingController();
  TextEditingController _passwordcontrolller = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();
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
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child:
                              Icon(Icons.arrow_back_ios, color: Colors.black)),
                      title: Text(
                        "Create an account",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration:
                        Get.isDarkMode ? txtDecorationDark : txtDecoration,
                    child: TextFormField(
                      controller: _usenameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "should not be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Full Name"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration:
                        Get.isDarkMode ? txtDecorationDark : txtDecoration,
                    child: TextFormField(
                      controller: _emalcontroller,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return 'Enter a valid email!';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid password!';
                        }
                        return null;
                      },
                      // obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter password",
                      ),
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
                      controller: _confirmpassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid password!';
                        } else if (_passwordcontrolller.text !=
                            _confirmpassword.text) {
                          return 'password do not match';
                        }
                        return null;
                      },
                      // obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Confirm password",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState != null) {
                        if (_formKey.currentState!.validate()) {
                          User? user =
                              await _authcontroller.signinwithemailandpassword(
                                  _emalcontroller.text,
                                  _passwordcontrolller.text,
                                  _usenameController.text);

                          if (user != null) {
                            Get.to(LoginScreen());
                          }
                        }
                      }
                    },
                    child: Text("Register"),
                  ),
                  Container(
                    width: 250,
                    child: Row(
                      children: [
                        Text("Already have an account?"),
                        TextButton(
                            onPressed: () {
                              Get.to(LoginScreen());
                            },
                            child: Text("Login"))
                      ],
                    ),
                  )
                ]),
          ),
        ),
      )),
    );
  }
}
