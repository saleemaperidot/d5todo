import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:todolist/Models/taskModel.dart';
import 'package:todolist/constants/constants.dart';
import 'package:todolist/controller/task_controller.dart';
import 'package:todolist/views/settings_screen.dart';
import 'package:todolist/views/singletodo.dart';

class TodoHome extends StatelessWidget {
  TodoHome({super.key});
  TaskController _taskcontrolller = Get.put(TaskController());
  TextEditingController _text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.grey.shade800 : Colors.white,
        elevation: 0,
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
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Icon(
            Icons.search,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              Get.to(SettingsScreen());
            },
          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Card(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/profile.jpg',
                    width: 50.0, // Adjust the width as needed
                    height: 50.0, // Adjust the height as needed
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  " 'The memmories are a shield and life is helper.' ",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                ),
                subtitle: Text('Tamim al bargouti'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: Obx(() {
              return _taskcontrolller.taskList.isEmpty
                  ? SizedBox()
                  : GridView.count(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: List.generate(
                          _taskcontrolller.taskList.length + 1, (index) {
                        final List<TaskModel> _tasklist =
                            _taskcontrolller.taskList;
                        return index == 0
                            ? InkWell(
                                onTap: () {
                                  Get.defaultDialog(
                                    barrierDismissible: false,
                                    title: "Add Task",
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: _text,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                hintText: "Enter task name"),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text("cancel")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      _taskcontrolller
                                                          .addTask(_text.text);
                                                      Get.back();
                                                    },
                                                    child: Text("Add"))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  child: Center(
                                    child: CircleAvatar(
                                        backgroundColor: Colors.black,
                                        child: Icon(
                                          Icons.add_rounded,
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  Get.to(SingleTodo(
                                    id: _tasklist[index - 1].id,
                                    taskname: _tasklist[index - 1].taskname,
                                  ));
                                },
                                child: Card(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image(
                                          width: 30,
                                          height: 30,
                                          image: AssetImage("assets/icon.png")),
                                      Text(_tasklist[index - 1].taskname),
                                      Text("5 Task"),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  _taskcontrolller.delete(
                                                      _tasklist[index - 1].id);
                                                },
                                                child: Icon(Icons.delete))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                      }),
                    );
            }))
          ],
        ),
      )),
    );
  }
}
