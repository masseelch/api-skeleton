// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) {
  return Session()
    ..id = json['id'] as String
    ..idleTimeExpiredAt = json['idleTimeExpiredAt'] == null
        ? null
        : DateTime.parse(json['idleTimeExpiredAt'] as String)
    ..lifeTimeExpiredAt = json['lifeTimeExpiredAt'] == null
        ? null
        : DateTime.parse(json['lifeTimeExpiredAt'] as String);
}

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'idleTimeExpiredAt': instance.idleTimeExpiredAt?.toIso8601String(),
      'lifeTimeExpiredAt': instance.lifeTimeExpiredAt?.toIso8601String(),
    };
