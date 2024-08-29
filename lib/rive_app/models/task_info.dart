import 'package:appflowy_board/appflowy_board.dart';

class TaskInfo extends AppFlowyGroupItem{
  String? taskPosition;
  String? taskTitle;
  String? taskSubtitle;
  double? taskProgressValue;
  String? taskStatus;

  TaskInfo(String taskPos, String taskTitle, String taskSub, double taskProgressValue, String taskStatus){
    this.taskPosition = taskPos;
    this.taskTitle = taskTitle;
    this.taskSubtitle = taskSub;
    this.taskProgressValue = taskProgressValue;
    this.taskStatus = taskStatus;
  }

  @override
  // TODO: implement id
  String get id => taskTitle!;
}

class TasksSummary{
  String? taskCategory;
  List<TaskInfo>? listTaskInfo;
  TasksSummary(String? taskCategory, List<TaskInfo>? taskInfo){
    this.taskCategory = taskCategory;
    this.listTaskInfo = taskInfo;
  }
}