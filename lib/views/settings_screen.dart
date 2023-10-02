import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:todolist/controller/auth_controller.dart';
import 'package:todolist/views/general_settings.dart';
import 'package:todolist/views/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.grey.shade800 : Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        automaticallyImplyLeading: true,
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView(
        children: [
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/my.jpg',
                  width: 30.0, // Adjust the width as needed
                  height: 30.0, // Adjust the height as needed
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              "Malak idrees",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Rabat morocco"),
            trailing: Icon(Icons.edit),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
              "Hi,My name is Malak,I`m a community manager from morocco,rabat"),
          SizedBox(
            height: 30,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notification"),
          ),
          InkWell(
            onTap: () {
              Get.to(GeneralSettings());
            },
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text("General"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Account"),
          ),
          ListTile(
            leading: Icon(Icons.money_sharp),
            title: Text("about"),
          ),
          ElevatedButton(
              onPressed: () {
                Get.find<AuthController>().signOut();
                Get.offAll(LoginScreen());
              },
              child: Text("Logout"))
        ],
      )),
    );
  }
}
