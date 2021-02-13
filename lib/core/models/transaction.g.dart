// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    id: json['id'] as int,
    customerId: json['customerId'] as int,
    amount: json['amount'] as num,
    date: Transaction.dateFromJson(json['date'] as int),
    description: json['description'] as String,
    type: Transaction.typeFromJson(json['type'] as int),
  );
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'amount': instance.amount,
      'description': instance.description,
      'type': Transaction.typeToJson(instance.type),
      'date': Transaction.dateToJson(instance.date),
    };
