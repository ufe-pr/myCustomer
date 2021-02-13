// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_h.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageHAdapter extends TypeAdapter<MessageH> {
  @override
  final typeId = 7;

  @override
  MessageH read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageH(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as DateTime,
      fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MessageH obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.storeIdFrom)
      ..writeByte(2)
      ..write(obj.customerIdTo)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.dateSent)
      ..writeByte(6)
      ..write(obj.transactionIdFor);
  }
}
