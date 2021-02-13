// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_h.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionHAdapter extends TypeAdapter<TransactionH> {
  @override
  final typeId = 10;

  @override
  TransactionH read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionH(
      fields[0] as String,
      fields[1] as double,
      fields[2] as DateTime,
      fields[3] as TransactionType,
      fields[4] as String,
      fields[5] as DateTime,
      fields[6] as bool,
      fields[7] as String,
      fields[8] as String,
      fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionH obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.dateAdded)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.customerIdFrom)
      ..writeByte(5)
      ..write(obj.dateDue)
      ..writeByte(6)
      ..write(obj.isCleared)
      ..writeByte(7)
      ..write(obj.storeIdFor)
      ..writeByte(8)
      ..write(obj.idCreatedBy)
      ..writeByte(9)
      ..write(obj.idClearedBy);
  }
}
