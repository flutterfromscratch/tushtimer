// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityTimerAdapter extends TypeAdapter<ActivityTimer> {
  @override
  final int typeId = 1;

  @override
  ActivityTimer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivityTimer(
      name: fields[0] as String,
      intervalDurationMinutes: fields[2] as int,
      restDurationSeconds: fields[3] as int,
      automaticRepeat: fields[4] as bool,
      color: fields[5] as Color,
    );
  }

  @override
  void write(BinaryWriter writer, ActivityTimer obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.intervalDurationMinutes)
      ..writeByte(3)
      ..write(obj.restDurationSeconds)
      ..writeByte(4)
      ..write(obj.automaticRepeat)
      ..writeByte(5)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityTimerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
