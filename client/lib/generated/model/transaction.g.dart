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
    ..amount = json['amount'] as int
    ..edges = json['edges'] == null
        ? null
        : TransactionEdges.fromJson(json['edges'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'amount': instance.amount,
      'edges': instance.edges?.toJson(),
    };

TransactionEdges _$TransactionEdgesFromJson(Map<String, dynamic> json) {
  return TransactionEdges()
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..account = json['account'] == null
        ? null
        : Account.fromJson(json['account'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TransactionEdgesToJson(TransactionEdges instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'account': instance.account?.toJson(),
    };
