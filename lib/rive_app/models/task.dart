import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectTask {
  final String? taskId;
  final String taskName;
  final bool taskFinished;
  final Timestamp timeStamp;

  ProjectTask(
      {this.taskId,
      required this.taskName,
      required this.taskFinished,
      required this.timeStamp});

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'taskName': taskName,
      'taskFinished': taskFinished,
      'timeStamp': timeStamp,
    };
  }
}

class SubTask {
  final String? subTaskId;
  final String subTaskName;
  final bool subTaskFinished;
  final Timestamp timeStamp;

  SubTask({this.subTaskId, required this.subTaskFinished, required this.subTaskName, required this.timeStamp});
  
  Map<String, dynamic> toMap() {
    return {
      'subTaskId': subTaskId,
      'subTaskName': subTaskName,
      'subTaskFinished': subTaskFinished,
      'timeStamp': timeStamp,
    };
  }
}
