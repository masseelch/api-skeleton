// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$AccountCreateRequestToJson(
        AccountCreateRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'users': instance.users?.map((e) => e?.toJson())?.toList(),
      'transactions': instance.transactions?.map((e) => e?.toJson())?.toList(),
    };

Map<String, dynamic> _$AccountUpdateRequestToJson(
        AccountUpdateRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'users': instance.users?.map((e) => e?.toJson())?.toList(),
      'transactions': instance.transactions?.map((e) => e?.toJson())?.toList(),
    };
