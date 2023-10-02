import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:todolist/Models/taskItemModel.dart';
import 'package:todolist/controller/task_controller.dart';
import 'package:todolist/controller/task_item_controller.dart';

class SingleTodo extends StatelessWidget {
  SingleTodo({super.key, required this.id, required this.taskname});
  final String id;
  final String taskname;
  TextEditingController _text = TextEditingController();
  TaskItemController _taskController = Get.put(TaskItemController());
  bool completed = false;
  @override
  Widget build(BuildContext context) {
    _taskController.getAllTaskitem(id);
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Get.isDarkMode ? Colors.white : Colors.black),
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Get.isDarkMode ? Colors.grey.shade800 : Colors.white,
        elevation: 0,
        title: Text(
          taskname,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        actions: [
          Icon(
            Icons.search,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Enter task name"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("cancel")),
                        ElevatedButton(
                            onPressed: () async {
                              await _taskController.addTaskitems(
                                  _text.text, id);
                              _taskController.getAllTaskitem(id);
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
        child: Icon(Icons.add_rounded),
      ),
      body: SafeArea(child: Obx(() {
        return ListView.separated(
          itemBuilder: (context, index) {
            final List<TaskItemModel> _tasklist = _taskController.taskList;
            return Container(
              child: ListTile(
                leading: InkWell(
                  onTap: () {
                    _taskController.toggleBool();
                    _taskController.updateTask(
                        id: id, taskid: _tasklist[index].id);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 15,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor:
                          _tasklist[index].status ? Colors.blue : Colors.white,
                      child: _tasklist[index].status
                          ? Icon(Icons.done)
                          : SizedBox(),
                    ),
                  ),
                ),
                title: Text(_tasklist[index].taskname),
                trailing: IconButton(
                    icon: Icon(Icons.delete_outline),
                    onPressed: () {
                      _taskController.delete(id, _tasklist[index].id);
                    }),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: _taskController.taskList.length,
        );
      })),
    );
  }
}
