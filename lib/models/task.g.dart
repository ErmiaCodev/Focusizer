// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      name: fields[0] as String,
      caption: fields[1] as String,
      date: fields[5] as DateTime,
      duration: fields[3] as int,
      topic: fields[2] as String?,
      completedDate: fields[7] as DateTime?,
      deepFocus: fields[4] as bool,
      done: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.caption)
      ..writeByte(2)
      ..write(obj.topic)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.deepFocus)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.done)
      ..writeByte(7)
      ..write(obj.completedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
