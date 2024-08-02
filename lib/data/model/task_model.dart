class TaskModel {
  int? id;
  String title;
  String note;
  String date;
  String? startTime;
  String? endTime;
  String repeat;
  String remind;
  int color;

  TaskModel({
    required this.title,
    required this.note,
    required this.date,
    this.startTime,
    this.endTime,
    required this.repeat,
    required this.remind,
    required this.color,
  });
}
