// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant_h.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssistantHAdapter extends TypeAdapter<AssistantH> {
  @override
  final typeId = 9;

  @override
  AssistantH read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AssistantH(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
      fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AssistantH obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.storeId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.pNum)
      ..writeByte(4)
      ..write(obj.ctyCode);
  }
}
