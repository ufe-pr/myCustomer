// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_manager_model_h.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PasswordManagerAdapter extends TypeAdapter<PasswordManager> {
  @override
  final typeId = 1;

  @override
  PasswordManager read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PasswordManager(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PasswordManager obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.userPassword);
  }
}
