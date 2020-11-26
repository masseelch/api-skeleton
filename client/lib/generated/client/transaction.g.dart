// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$TransactionCreateRequestToJson(
        TransactionCreateRequest instance) =>
    <String, dynamic>{
      'date': instance.date?.toUtc().toIso8601String(),
      'amount': const MoneyConverter().toJson(instance.amount),
      'title': instance.title,
      'user': instance.user?.toJson(),
      'account': instance.account?.toJson(),
      'tags': instance.tags?.map((e) => e?.toJson())?.toList(),
    };

Map<String, dynamic> _$TransactionUpdateRequestToJson(
        TransactionUpdateRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'amount': const MoneyConverter().toJson(instance.amount),
      'title': instance.title,
      'user': instance.user?.toJson(),
      'account': instance.account?.toJson(),
      'tags': instance.tags?.map((e) => e?.toJson())?.toList(),
    };
