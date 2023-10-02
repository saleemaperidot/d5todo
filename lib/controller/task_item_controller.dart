import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:todolist/Models/taskItemModel.dart';
import 'package:todolist/Models/taskModel.dart';

class TaskItemController extends GetxController {
  RxBool myBool = false.obs; // Initialize as false

  String uid = FirebaseAuth.instance.currentUser!.uid;
  RxList<TaskItemModel> taskList = <TaskItemModel>[].obs;
  RxInt pendingTaskCount = 0.obs;

  // Toggle the boolean value
  void toggleBool() {
    myBool.toggle();
  }

  // String docId = "";
  @override
  void onInit() {
    //   // TODO: implement onInit
    super.onInit();
  }

  ///add item to task
  ///
  ///
  ///
  void getAllTaskitem(String docId) {
    print("Get all task called");
    try {
      taskList.bindStream(FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('task')
          .doc(docId)
          .collection("taskitem")
          .snapshots()
          .map((query) {
        List<TaskItemModel> tasks = [];
        query.docs.forEach((element) {
          print("foreach");
          TaskItemModel task = TaskItemModel.fromQuerySnapShort(element);
          tasks.add(task);
        });
        //  taskList.addAll(tasks);
        print("task in controller$tasks");
        return tasks;
      }));
    } catch (e) {
      print(e);
    }
  }

  Future<void> addTaskitems(String taskname, String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('task')
          .doc(docId)
          .collection("taskitem")
          .add({"taskname": taskname, "ComplettionStaus": false});
    } catch (e) {
      Get.defaultDialog(title: e.toString());
    }
  }

  void getTask() {
    taskList.clear();
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('task')
        .snapshots()
        .map(
      (query) {
        List<TaskItemModel> tasks = [];
        query.docs.forEach((element) {
          TaskItemModel task = TaskItemModel.fromQuerySnapShort(element);
          tasks.add(task);
        });
        taskList.addAll(tasks);
        print("task in controller$tasks");
        return tasks;
      },
    );
  }

  Future<void> delete(String id, String taskId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('task')
        .doc(id)
        .collection('taskitem')
        .doc(taskId)
        .delete();
    // getPendingTask();
  }

  void updateTask({
    required String id,
    required String taskid,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('task')
        .doc(id)
        .collection('taskitem')
        .doc(taskid)
        .update({
      "ComplettionStaus": myBool.value,
    });
  }
}
