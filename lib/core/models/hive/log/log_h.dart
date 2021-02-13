import 'package:hive/hive.dart';

part 'log_h.g.dart';

/// A Hive Database compatible Log Model
///   - @HiveType(typeId: unique) is necessary for each HiveObject
///   - @HiveField(unique) is necessary if you need the object to persist
@HiveType(typeId: 4)
class LogH extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final DateTime timestamp;

  LogH(this.id, this.description, this.type, this.timestamp);

  static fromStoreH(LogH e) {}

  static fromMap(map) {}

  static toMap() {}
}