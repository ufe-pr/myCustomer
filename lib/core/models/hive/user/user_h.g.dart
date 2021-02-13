// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_h.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserHAdapter extends TypeAdapter<UserH> {
  @override
  final typeId = 5;

  @override
  UserH read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserH(
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
      fields[4] as int,
      fields[5] as String,
      fields[6] as String,
      fields[7] as String,
      fields[8] as Uint8List,
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserH obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.pNum)
      ..writeByte(4)
      ..write(obj.ctyCode)
      ..writeByte(5)
      ..write(obj.fName)
      ..writeByte(6)
      ..write(obj.lName)
      ..writeByte(7)
      ..write(obj.pwd)
      ..writeByte(8)
      ..write(obj.displayPic);
  }
}
