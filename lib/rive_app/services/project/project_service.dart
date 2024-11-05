import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rive_learning/rive_app/models/project_info.dart';
import 'package:rive_learning/rive_app/models/task.dart';
import 'package:uuid/uuid.dart';

class ProjectService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //ADD PROJECT
  Future<void> addProject(Project project) async {
    //get user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //add new project to database
    await _firestore
        .collection('project_store')
        .doc(currentUserId)
        .collection('projects')
        .doc(Uuid().v4())
        .set(project.toMap());
    // .add(project.toMap());
  }

  //DELETE PROJECT
  Future<void> deleteProject(String projectId) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    await _firestore
        .collection('project_store')
        .doc(currentUserId)
        .collection('projects')
        .doc(projectId)
        .delete()
        .then(
          (doc) => print('Project deleted'),
          onError: (e) => print("Error deleting document"),
        );
  }

  //UPDATE PROJECT
  Future<void> updateProject(String projectId, Project projectUpdate) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    await _firestore
        .collection('project_store')
        .doc(currentUserId)
        .collection('projects')
        .doc(projectId)
        .update({
      "projectName": projectUpdate.projectName,
      "projectPosition": projectUpdate.projectPosition,
      "projectDesc": projectUpdate.projectDesc,
      "projectUrgent": projectUpdate.projectUrgent,
      "projectFinished": projectUpdate.projectFinished,
      "timeStamp": projectUpdate.timeStamp,
    }).then(
      (doc) => print('Project updated'),
      onError: (e) => print("Error deleting document"),
    );
  }

  //GET PROJECTS
  Future<QuerySnapshot<Map<String, dynamic>>> getAllProjects2() async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    return await _firestore
        .collection('project_store')
        .doc(currentUserId)
        .collection('projects')
        .orderBy('timeStamp', descending: true)
        .get();
  }
}
