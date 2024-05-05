import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String caption;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  bool done;

  @HiveField(4)
  DateTime? completedDate;

  Task({
    required this.name,
    required this.caption,
    required this.date,
    this.done = false,
  });
}
