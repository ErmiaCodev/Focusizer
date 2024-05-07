import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String caption;

  @HiveField(2)
  String? topic;

  @HiveField(3)
  int duration;

  @HiveField(4)
  bool deepFocus;

  @HiveField(5)
  DateTime date;

  @HiveField(6)
  bool done;

  @HiveField(7)
  DateTime? completedDate;

  Task({
    required this.name,
    required this.caption,
    required this.date,
    required this.duration,
    this.topic,
    this.completedDate,
    this.deepFocus = false,
    this.done = false,
  });
}
