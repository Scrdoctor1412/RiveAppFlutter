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

  //GET PROJECTS
  // Stream<QuerySnapshot> getProjects(String userId) {
  //   return _firestore
  //       .collection('project_store')
  //       .doc(userId)
  //       .collection('projects')
  //       .orderBy('timeStamp', descending: true)
  //       .snapshots();
  // }

  // List<Map<String, dynamic>> getAllProjects(String userId) {
  //   List<Map<String, dynamic>> temp = [];
  //   _firestore
  //       .collection('project_store')
  //       .doc(userId)
  //       .collection('projects')
  //       .get()
  //       .then(
  //     (querySnapshot) {
  //       print("Successfully completed");
  //       for (var docSnapshot in querySnapshot.docs) {
  //         // print('${docSnapshot.id} => ${docSnapshot.data()}');
  //         print('success');
  //         temp.add(docSnapshot.data());
  //         print(temp[0]);
  //       }
  //     },
  //     onError: (e) => print("error: $e"),
  //   );
  //   return temp;
  // }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllProjects2() async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    return await _firestore
        .collection('project_store')
        .doc(currentUserId)
        .collection('projects')
        .orderBy('timeStamp', descending: false)
        .get();
  }
}
