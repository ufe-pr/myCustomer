import 'package:hive/hive.dart';

part 'transaction_h.g.dart';

enum TransactionType { debit, credit }

@HiveType(typeId: 10)
class TransactionH {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime dateAdded;

  @HiveField(3)
  final TransactionType type;

  @HiveField(4)
  final String customerIdFrom;

  @HiveField(5)
  final DateTime dateDue;

  @HiveField(6)
  final bool isCleared;

  @HiveField(7)
  final String storeIdFor;

  @HiveField(8)
  final String idCreatedBy;

  @HiveField(9)
  final String idClearedBy;

  TransactionH(
      this.id,
      this.amount,
      this.dateAdded,
      this.type,
      this.customerIdFrom,
      this.dateDue,
      this.isCleared,
      this.storeIdFor,
      this.idCreatedBy,
      this.idClearedBy);
}
