import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'user_h.g.dart';

/// A Hive Database compatible User Model
///   - @HiveType(typeId: unique) is necessary for each HiveObject
///   - @HiveField(unique) is necessary if you need the object to persist
@HiveType(typeId: 5)
class UserH extends HiveObject {
  @HiveField(0)
   final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final int pNum;

  @HiveField(4)
  final int ctyCode;

  @HiveField(5)
  final String fName;

  @HiveField(6)
  final String lName;

  @HiveField(7)
  final String pwd;

  @HiveField(8)
  final Uint8List displayPic;

  UserH(this.email, this.name, this.pNum, this.ctyCode, this.fName, this.lName, this.pwd, this.displayPic, this.id);

}