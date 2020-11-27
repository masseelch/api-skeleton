// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$TransactionCreateRequestToJson(
        TransactionCreateRequest instance) =>
    <String, dynamic>{
      'date': const DateUtcConverter().toJson(instance.date),
      'amount': const MoneyConverter().toJson(instance.amount),
      'title': instance.title,
      'user': instance.user,
      'account': instance.account,
      'tags': instance.tags,
    };

Map<String, dynamic> _$TransactionUpdateRequestToJson(
        TransactionUpdateRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': const DateUtcConverter().toJson(instance.date),
      'amount': const MoneyConverter().toJson(instance.amount),
      'title': instance.title,
      'user': instance.user,
      'account': instance.account,
      'tags': instance.tags,
    };
