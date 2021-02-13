import 'package:hive/hive.dart';

part 'transaction_model_h.g.dart';

@HiveType(typeId: 3, adapterName: 'TransactionAdapter')

class TransactionModel extends HiveObject{

  @HiveField(0)
  final String cId;

  @HiveField(1)
  final String sId;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final double paid;

  @HiveField(4)
  final String duedate;

  @HiveField(5)
  final String boughtdate;

  @HiveField(6)
  final String paiddate;

  @HiveField(7)
  final String description;

  TransactionModel({this.cId, this.sId, this.amount, this.paid, this.duedate, this.boughtdate, this.paiddate, this.description});
}