import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TaskItemModel {
  late String id;
  late String taskname;
  // late String taskdiscription;
  // late String? duedate;
  late bool status;
  // late String assigneddate;
  TaskItemModel(
      this.id,
      this.taskname,
      // this.taskdiscription,
      // this.assigneddate,
      //   this.duedate,
      this.status);
  TaskItemModel.fromQuerySnapShort(QueryDocumentSnapshot<Object?> query) {
    id = query.id;
    taskname = query['taskname'];
    // taskdiscription = query['taskdiscription'];
    //duedate = query['duedate'];
    status = query['ComplettionStaus'];
    // assigneddate = query['assigneddate'];
  }

  TaskItemModel.fromDocumentSnapshort(
      DocumentSnapshot<Map<String, dynamic>> query) {
    id = query.id;
    taskname = query['taskname'];
    // taskdiscription = query['taskdiscription'];
    // duedate = query['duedate'];
    status = query['ComplettionStaus'];
    // assigneddate = query['assigneddate'];
  }
}
