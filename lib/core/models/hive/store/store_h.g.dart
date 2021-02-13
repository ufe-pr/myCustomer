// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_h.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoreHAdapter extends TypeAdapter<StoreH> {
  @override
  final typeId = 6;

  @override
  StoreH read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreH(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
      fields[4] as int,
      fields[5] as String,
      fields[6] as String,
      fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StoreH obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.pNum)
      ..writeByte(4)
      ..write(obj.ctyCode)
      ..writeByte(5)
      ..write(obj.tagline)
      ..writeByte(6)
      ..write(obj.ownerId)
      ..writeByte(7)
      ..write(obj.email);
  }
}
