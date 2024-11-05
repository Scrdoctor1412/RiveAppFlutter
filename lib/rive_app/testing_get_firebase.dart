import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:rive_learning/rive_app/models/project_info.dart';
import 'package:rive_learning/rive_app/models/task.dart';
import 'package:rive_learning/rive_app/services/project/project_service.dart';
import 'package:rive_learning/rive_app/services/task/task_service.dart';
import 'package:uuid/uuid.dart';

class TestingGetFirebase extends StatefulWidget {
  const TestingGetFirebase({Key? key}) : super(key: key);

  @override
  _TestingGetFirebaseState createState() => _TestingGetFirebaseState();
}

class _TestingGetFirebaseState extends State<TestingGetFirebase> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ProjectService _projectService = ProjectService();
  final TaskService _taskService = TaskService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  testing();
                },
                child: const Text('Get'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  addProject();
                },
                child: const Text('Add project'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  testingAddTask();
                },
                child: const Text('add task'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  testingAddSubTask();
                },
                child: const Text('add sub task'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  testingGetTasks();
                },
                child: const Text('get task'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addProject() async {
    await _projectService.addProject(Project(
        projectId: Uuid().v4(),
        projectPosition: 'Dev',
        projectName: 'hello world',
        projectDesc: 'hello',
        projectUrgent: 'low',
        projectFinished: false,
        timeStamp: Timestamp.now()));
  }

  void testing() async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    // List<Map<String, dynamic>> _list = _projectService.getAllProjects(_firebaseAuth.currentUser!.uid);
    // print("length: ${_list.length}");
    List<Map<String, dynamic>> _list = [];

    await _projectService.getAllProjects2().then((querySnapshot) {
      print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()['projectName']}');
        _list.add(docSnapshot.data());
        print('success');
      }
    });

    print("length: ${_list.length}");
  }

  void testingAddTask() async {
    await _taskService.addTaskToProject(
      'jKeMZdu58Tt9anzCeZOn',
      ProjectTask(
        taskId: Uuid().v4(),
        taskName: 'testing',
        taskFinished: false,
        timeStamp: Timestamp.now(),
      ),
    );
  }

  void testingGetTasks() async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    await _taskService.getTasks2('jKeMZdu58Tt9anzCeZOn').then((querySnapshot) {
      print('Successfully');
      for (var docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()['taskId']}');
        // print(docSnapshot
        // _list.add(docSnapshot.data());
        print('success');
      }
    });
  }

  void testingAddSubTask() async {
    await _taskService.addSubTaskToTask(
        'FzF3yCuxC5UkIt3qBA2j',
        '10lhKof5dqhSOj63hkUy',
        SubTask(
            subTaskFinished: false,
            subTaskName: 'sub task test',
            timeStamp: Timestamp.now()));
  }
}
