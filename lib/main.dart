import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todolist/constants/constants.dart';
import 'package:todolist/controller/auth_controller.dart';

import 'package:todolist/views/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todolist/views/todo_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 3000,
        splash: Image(image: AssetImage('assets/spash.png')),
        nextScreen: Root(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'todo list using firebase',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: SplashScreenWidget(),
    );
  }
}

class Root extends StatelessWidget {
  Root({super.key});
  AuthController _authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print("${_authController.user.value}");
      return _authController.user.value == null ? LoginScreen() : TodoHome();
    });
  }
}
