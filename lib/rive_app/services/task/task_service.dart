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
  Stream<QuerySnapshot> getTasks(String userId, String projectId) {
    return _firestore
        .collection('project_store')
        .doc(userId)
        .collection('projects')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getTasks2(String projectId) {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    return _firestore
        .collection('project_store')
        .doc(currentUserId)
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .orderBy('timeStamp', descending: false)
        .get();
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
        .add(subTask.toMap());
  }
}
