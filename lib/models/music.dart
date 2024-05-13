import 'package:hive/hive.dart';

part 'music.g.dart';

@HiveType(typeId: 4)
class Music extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String path;

  Music({
    required this.name,
    required this.path,
  });
}
