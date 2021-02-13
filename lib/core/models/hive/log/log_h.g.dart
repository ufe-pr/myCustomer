// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_h.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogHAdapter extends TypeAdapter<LogH> {
  @override
  final typeId = 4;

  @override
  LogH read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LogH(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LogH obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.timestamp);
  }
}
