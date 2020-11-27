// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$TagCreateRequestToJson(TagCreateRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'color': const ColorConverter().toJson(instance.color),
      'transactions': instance.transactions,
    };

Map<String, dynamic> _$TagUpdateRequestToJson(TagUpdateRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'color': const ColorConverter().toJson(instance.color),
      'transactions': instance.transactions,
    };
