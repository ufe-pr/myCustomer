import 'package:hive/hive.dart';

part 'assistant_h.g.dart';

/// A Hive Database compatible Log Model
///   - @HiveType(typeId: unique) is necessary for each HiveObject
///   - @HiveField(unique) is necessary if you need the object to persist
@HiveType(typeId: 9)
class AssistantH extends HiveObject{
  @HiveField(0)
  final  String id;

  @HiveField(1)
   final String storeId;

  @HiveField(2)
  final  String name;

  @HiveField(3)
   final int pNum;

  @HiveField(4)
  final  int ctyCode;

  AssistantH(this.id, this.storeId, this.name, this.pNum, this.ctyCode);

}