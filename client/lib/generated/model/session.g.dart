// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) {
  return Session()
    ..id = json['id']
    ..idleTimeExpiredAt =
        const DateUtcConverter().fromJson(json['idleTimeExpiredAt'] as String)
    ..lifeTimeExpiredAt =
        const DateUtcConverter().fromJson(json['lifeTimeExpiredAt'] as String)
    ..edges = json['edges'] == null
        ? null
        : SessionEdges.fromJson(json['edges'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'idleTimeExpiredAt':
          const DateUtcConverter().toJson(instance.idleTimeExpiredAt),
      'lifeTimeExpiredAt':
          const DateUtcConverter().toJson(instance.lifeTimeExpiredAt),
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
