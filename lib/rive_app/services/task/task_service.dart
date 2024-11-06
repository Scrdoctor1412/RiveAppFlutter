import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rive_learning/rive_app/models/task.dart';
import 'package:uuid/uuid.dart';

class TaskService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //ADD TASK TO PROJECT
  Future<void> addTaskToProject(String projectId, ProjectTask task) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    //add new task to project in database
    await _firestore
        .collection('project_store')
        .doc(currentUserId)
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .doc(Uuid().v4())
        .set(task.toMap());
        // .add(task.toMap());
  }

  //GET TASKS
  Future<QuerySnapshot<Map<String, dynamic>>> getTasks2(String projectId) {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    return _firestore
        .collection('project_store')
        .doc(currentUserId)
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        // .orderBy('timeStamp', descending: false)
        .get();
  }

  //GET ALL SUBTASK FROM A TASK
  Future<QuerySnapshot<Map<String, dynamic>>> getSubTask(String projectId, String taskId) {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    return _firestore
        .collection('project_store')
        .doc(currentUserId)
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .doc(taskId)
        .collection('subtasks')
        .orderBy('timeStamp', descending: true)
        .get();
  }

  //DELETE TASK
  Future<int> deleteTask(String projectId, String taskId) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    int flag = -1;
    await _firestore
        .collection('project_store')
        .doc(currentUserId)
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .doc(taskId)
        .delete()
        .then(
          (doc) => flag = 1,
          onError: (e) => print("Error deleting document"),
        );
    return flag;
  }

  //UPDATE TASK
  Future<void> updateTask(String projectId, String taskId, ProjectTask taskUpdate) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    await _firestore
        .collection('project_store')
        .doc(currentUserId)
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .doc(taskId)
        .update({
          "taskName": taskUpdate.taskName,
          "taskFinished": taskUpdate.taskFinished,
          "timeStamp": taskUpdate.timeStamp,
        })
        .then(
          (doc) => print('update successfuly'),
          onError: (e) => print("Error deleting document"),
        );
  }

  //ADD SUBTASK TO TASK OF A PROJECT
  Future<void> addSubTaskToTask(
      String projectId, String taskId, SubTask subTask) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    await _firestore
        .collection('project_store')
        .doc(currentUserId)
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .doc(taskId)
        .collection('subtasks')
        .doc(Uuid().v4())
        .set(subTask.toMap());
      }
}
