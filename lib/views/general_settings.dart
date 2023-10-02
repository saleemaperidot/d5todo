import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:todolist/controller/theme_controller.dart';

class GeneralSettings extends StatelessWidget {
  GeneralSettings({super.key});
  final ThemeController _themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
          child: Obx(
        () => Container(
          child: ElevatedButton(
              onPressed: () {
                _themeController.toggleTheme();

                Get.changeTheme(
                    Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
              },
              child: _themeController.isDarkMode.value
                  ? Text("Light")
                  : Text("darks Mode")),
        ),
      )),
    );
  }
}
