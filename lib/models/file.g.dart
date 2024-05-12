// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserFileAdapter extends TypeAdapter<UserFile> {
  @override
  final int typeId = 3;

  @override
  UserFile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserFile(
      name: fields[0] as String,
      path: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserFile obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserFileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
