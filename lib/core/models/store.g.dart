// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json) {
  return Store(
    json['_id'] as String,
    json['email'] as String,
    json['phone_number'] as String,
    json['tagline'] as String,
    json['shop_address'] as String,
  )..name = json['store_name'] as String;
}

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'tagline': instance.tagline,
      'phone_number': instance.phone,
      'shop_address': instance.address,
      'store_name': instance.name,
    };
