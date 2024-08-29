class DailyTask{
  String? taskTitle;
  String? taskStatus;
  DateTime? beginTime;
  DateTime? endTime;

  DailyTask(String taskTitle, String taskStatus, DateTime beginTime, DateTime endTime){
    this.taskStatus = taskStatus;
    this.taskTitle = taskTitle;
    this.beginTime = beginTime;
    this.endTime = endTime;
  }
}