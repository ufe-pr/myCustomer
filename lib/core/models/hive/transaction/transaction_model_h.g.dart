// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model_h.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionAdapter extends TypeAdapter<TransactionModel> {
  @override
  final typeId = 3;

  @override
  TransactionModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionModel(
      cId: fields[0] as String,
      sId: fields[1] as String,
      amount: fields[2] as double,
      paid: fields[3] as double,
      duedate: fields[4] as String,
      boughtdate: fields[5] as String,
      paiddate: fields[6] as String,
      description: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.cId)
      ..writeByte(1)
      ..write(obj.sId)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.paid)
      ..writeByte(4)
      ..write(obj.duedate)
      ..writeByte(5)
      ..write(obj.boughtdate)
      ..writeByte(6)
      ..write(obj.paiddate)
      ..writeByte(7)
      ..write(obj.description);
  }
}
