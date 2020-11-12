// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..description = json['description'] as String;
}

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
    };
