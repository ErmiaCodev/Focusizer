import 'package:hive/hive.dart';

part 'file.g.dart';

@HiveType(typeId: 3)
class UserFile extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String path;

  @HiveField(2)
  String type;

  UserFile({
    required this.name,
    required this.path,
    required this.type,
  });
}
