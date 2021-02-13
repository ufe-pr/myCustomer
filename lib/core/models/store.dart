import 'package:json_annotation/json_annotation.dart';

import 'hive/store/store_h.dart';

part 'store.g.dart';

@JsonSerializable(nullable: true, includeIfNull: true)
class Store {

  Store(this.id, this.email, this.phone, this.tagline, this.address);

  @JsonKey(name: '_id')
  String id;

  String email, tagline;

  @JsonKey(name: 'phone_number')
  String phone;

  @JsonKey(name: 'shop_address')
  String address;

  @JsonKey(name: 'store_name')
  String name;


  factory Store.fromStoreH(StoreH store) => Store(
      store.id,
      store.email,
      '${store.ctyCode}${store.pNum}',
      store.tagline,
      store.address,
    )..name = store.name;
  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
  Map<String, dynamic> toJson() => _$StoreToJson(this);

  @override
  String toString() => this.id;
}