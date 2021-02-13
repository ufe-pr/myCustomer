import 'package:hive/hive.dart';

part 'store_h.g.dart';

/// A Hive Database compatible Store Model
///   - @HiveType(typeId: unique) is necessary for each HiveObject
///   - @HiveField(unique) is necessary if you need the object to persist
@HiveType(typeId: 6)
class StoreH {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String address;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final int pNum;

  @HiveField(4)
  final int ctyCode;

  @HiveField(5)
  final String tagline;

  @HiveField(6)
  final String ownerId;

  @HiveField(7)
  final String email;

  StoreH(this.id, this.address, this.name, this.pNum, this.ctyCode,
      this.tagline, this.ownerId, this.email);
}
