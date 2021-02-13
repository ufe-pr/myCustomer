import 'package:hive/hive.dart';

part 'message_h.g.dart';

/// A Hive Database compatible Message Model
///   - @HiveType(typeId: unique) is necessary for each HiveObject
///   - @HiveField(unique) is necessary if you need the object to persist
@HiveType(typeId: 7)
class MessageH{
  @HiveField(0)
   final String id;

  @HiveField(1)
   final String storeIdFrom;

  @HiveField(2)
   final String customerIdTo;

  @HiveField(3)
  final  String content;

  @HiveField(4)
   final String title;

  @HiveField(5)
  final  DateTime dateSent;

  @HiveField(6)
   final String transactionIdFor;

  MessageH(this.id, this.storeIdFrom, this.customerIdTo, this.content, this.title, this.dateSent, this.transactionIdFor);
}