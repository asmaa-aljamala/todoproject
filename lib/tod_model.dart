
import 'package:todo/task_helper.dart';

class Task {
  int taskId;
  String taskName;
  bool isComplete;
  Task({this.taskId, this.taskName, this.isComplete});
  Task.fromMap(Map map) {
    this.taskId = map[TaskDbHelper.taskIdColumnName];
    this.taskName = map[TaskDbHelper.taskNameColumnName];
    this.isComplete =
        map[TaskDbHelper.taskIsCompleteColumnName] == 1 ? true : false;
  }
  Map<String, dynamic> toMap() {
    return {
      TaskDbHelper.taskNameColumnName: this.taskName,
      TaskDbHelper.taskIsCompleteColumnName: isComplete ? 1 : 0
    };
  }
}
