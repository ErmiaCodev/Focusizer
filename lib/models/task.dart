import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String? topic;

  @HiveField(2)
  int duration;

  @HiveField(3)
  bool deepFocus;

  @HiveField(4)
  int coins;

  @HiveField(5)
  DateTime date;

  Task({
    required this.name,
    required this.date,
    required this.duration,
    this.topic,
    this.deepFocus = false,
    this.coins = 0,
  });
}
