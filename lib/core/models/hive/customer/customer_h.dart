import 'package:hive/hive.dart';

part 'customer_h.g.dart';

/// A Hive Database compatible Log Model
///   - @HiveType(typeId: unique) is necessary for each HiveObject
///   - @HiveField(unique) is necessary if you need the object to persist
@HiveType(typeId: 8)
class CustomerH {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String storeIdFor;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final int pNum;

  @HiveField(4)
  final int ctyCode;
  
  @HiveField(5)
  final String email;

  CustomerH(this.id, this.storeIdFor, this.name, this.pNum, this.ctyCode, this.email);
}
