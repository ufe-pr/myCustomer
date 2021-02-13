import 'package:json_annotation/json_annotation.dart';
import 'package:mycustomers/core/enums/transaction_type.dart';

part 'transaction.g.dart';

@JsonSerializable(nullable: true, includeIfNull: true)
class Transaction {
  int id, customerId;
  num amount;
  String description;

  @JsonKey(fromJson: typeFromJson, toJson: typeToJson)
  TransactionType type;

  @JsonKey(toJson: dateToJson, fromJson: dateFromJson)
  DateTime date;

  Transaction({this.id, this.customerId, this.amount, this.date, this.description, this.type});

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  static TransactionType typeFromJson(int type) {
    return TransactionType.values[type + 1];
  }

  static int dateToJson(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch;
  }

  static DateTime dateFromJson(int timestamp) {
    return DateTime.fromMicrosecondsSinceEpoch(timestamp);
  }

  static int typeToJson(TransactionType type) {
    return type.index + 1;
  }
}