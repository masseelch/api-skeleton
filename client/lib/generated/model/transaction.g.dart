// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction()
    ..id = json['id'] as int
    ..date =
        json['date'] == null ? null : DateTime.parse(json['date'] as String)
    ..amount = json['amount'] as int;
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'amount': instance.amount,
    };
