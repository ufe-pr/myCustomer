// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_currency_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountryCurrencyAdapter extends TypeAdapter<CountryCurrency> {
  @override
  final typeId = 15;

  @override
  CountryCurrency read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountryCurrency(
      country: fields[0] as String,
      symbol: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CountryCurrency obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.country)
      ..writeByte(1)
      ..write(obj.symbol);
  }
}
