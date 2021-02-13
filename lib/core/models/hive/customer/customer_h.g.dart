// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_h.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerHAdapter extends TypeAdapter<CustomerH> {
  @override
  final typeId = 8;

  @override
  CustomerH read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerH(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
      fields[4] as int,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CustomerH obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.storeIdFor)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.pNum)
      ..writeByte(4)
      ..write(obj.ctyCode)
      ..writeByte(5)
      ..write(obj.email);
  }
}
