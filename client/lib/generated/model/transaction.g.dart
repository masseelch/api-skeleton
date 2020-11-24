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
    ..amount = const MoneyConverter().fromJson(json['amount'] as int)
    ..title = json['title'] as String
    ..edges = json['edges'] == null
        ? null
        : TransactionEdges.fromJson(json['edges'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'amount': const MoneyConverter().toJson(instance.amount),
      'title': instance.title,
      'edges': instance.edges?.toJson(),
    };

TransactionEdges _$TransactionEdgesFromJson(Map<String, dynamic> json) {
  return TransactionEdges()
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..account = json['account'] == null
        ? null
        : Account.fromJson(json['account'] as Map<String, dynamic>)
    ..tags = (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TransactionEdgesToJson(TransactionEdges instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'account': instance.account?.toJson(),
      'tags': instance.tags?.map((e) => e?.toJson())?.toList(),
    };
