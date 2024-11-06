import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

class ProjectTask {
  String? taskId;
  String taskName;

  bool taskFinished;
  Timestamp? startDay;
  Timestamp timeStamp;

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
  String? subTaskId;
  String subTaskName;
  bool subTaskFinished;
  Timestamp timeStamp;

  SubTask(
      {this.subTaskId,
      required this.subTaskFinished,
      required this.subTaskName,
      required this.timeStamp});

  Map<String, dynamic> toMap() {
    return {
      'subTaskId': subTaskId,
      'subTaskName': subTaskName,
      'subTaskFinished': subTaskFinished,
      'timeStamp': timeStamp,
    };
  }
}
