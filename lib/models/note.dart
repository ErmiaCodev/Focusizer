import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String caption;

  @HiveField(2)
  DateTime date;

  Note({
    required this.name,
    required this.caption,
    required this.date,
  });
}
