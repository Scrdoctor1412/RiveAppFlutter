import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectInfo {
  String? taskPosition;
  String? taskTitle;
  String? taskSubtitle;
  double? taskProgressValue;
  String? taskStatus;

  ProjectInfo(String taskPos, String taskTitle, String taskSub,
      double taskProgressValue, String taskStatus) {
    this.taskPosition = taskPos;
    this.taskTitle = taskTitle;
    this.taskSubtitle = taskSub;
    this.taskProgressValue = taskProgressValue;
    this.taskStatus = taskStatus;
  }

  //convert to a map
  Map<String, dynamic> toMap() {
    return {
      'taskPosition': taskPosition,
      'taskTitle': taskTitle,
      'taskSubtitle': taskSubtitle,
      'taskProgressValue': taskProgressValue,
      'taskStatus': taskStatus,
    };
  }

  @override
  // TODO: implement id
  String get id => taskTitle!;
}

class Project {
  String? projectId;
  String projectPosition;
  String projectName;
  String projectDesc;
  String projectUrgent;
  bool projectFinished;
  Timestamp timeStamp;

  Project(
      {this.projectId,
      required this.projectPosition,
      required this.projectName,
      required this.projectDesc,
      required this.projectUrgent,
      required this.projectFinished,
      required this.timeStamp});

  Map<String, dynamic> toMap() {
    return {
      'projectId': projectId,
      'projectPosition': projectPosition,
      'projectName': projectName,
      'projectDesc': projectDesc,
      'projectUrgent': projectUrgent,
      'projectFinished': projectFinished,
      'timeStamp': timeStamp
    };
  }

  factory Project.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Project(
        projectPosition: data?['projectPosition'],
        projectName: data?['projectName'],
        projectDesc: data?['projectDesc'],
        projectUrgent: data?['projectUrgent'],
        projectFinished: data?['projectFinished'],
        timeStamp: data?['timeStamp']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (projectPosition != null) "projectPosition": projectPosition,
      if (projectName != null) "projectName": projectName,
      if (projectDesc != null) "projectDesc": projectDesc,
      if (projectUrgent != null) "projectUrgent": projectUrgent,
      if (projectFinished != null) "projectFinished": projectFinished,
      if (timeStamp != null) "timeStamp": timeStamp,
    };
  }
}
