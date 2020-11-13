// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..edges = json['edges'] == null
        ? null
        : AccountEdges.fromJson(json['edges'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'edges': instance.edges?.toJson(),
    };

AccountEdges _$AccountEdgesFromJson(Map<String, dynamic> json) {
  return AccountEdges()
    ..users = (json['users'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..transactions = (json['transactions'] as List)
        ?.map((e) =>
            e == null ? null : Transaction.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AccountEdgesToJson(AccountEdges instance) =>
    <String, dynamic>{
      'users': instance.users?.map((e) => e?.toJson())?.toList(),
      'transactions': instance.transactions?.map((e) => e?.toJson())?.toList(),
    };
