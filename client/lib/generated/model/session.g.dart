// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) {
  return Session()
    ..id = json['id']
    ..idleTimeExpiredAt = json['idleTimeExpiredAt'] == null
        ? null
        : DateTime.parse(json['idleTimeExpiredAt'] as String)
    ..lifeTimeExpiredAt = json['lifeTimeExpiredAt'] == null
        ? null
        : DateTime.parse(json['lifeTimeExpiredAt'] as String)
    ..edges = json['edges'] == null
        ? null
        : SessionEdges.fromJson(json['edges'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'idleTimeExpiredAt': instance.idleTimeExpiredAt?.toIso8601String(),
      'lifeTimeExpiredAt': instance.lifeTimeExpiredAt?.toIso8601String(),
      'edges': instance.edges?.toJson(),
    };

SessionEdges _$SessionEdgesFromJson(Map<String, dynamic> json) {
  return SessionEdges()
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SessionEdgesToJson(SessionEdges instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
    };
