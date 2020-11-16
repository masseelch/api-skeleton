// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as int
    ..email = json['email'] as String
    ..password = json['password'] as String
    ..enabled = json['enabled'] as bool
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..edges = json['edges'] == null
        ? null
        : UserEdges.fromJson(json['edges'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'enabled': instance.enabled,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'edges': instance.edges?.toJson(),
    };

UserEdges _$UserEdgesFromJson(Map<String, dynamic> json) {
  return UserEdges()
    ..sessions = (json['sessions'] as List)
        ?.map((e) =>
            e == null ? null : Session.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..accounts = (json['accounts'] as List)
        ?.map((e) =>
            e == null ? null : Account.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..transactions = (json['transactions'] as List)
        ?.map((e) =>
            e == null ? null : Transaction.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$UserEdgesToJson(UserEdges instance) => <String, dynamic>{
      'sessions': instance.sessions?.map((e) => e?.toJson())?.toList(),
      'accounts': instance.accounts?.map((e) => e?.toJson())?.toList(),
      'transactions': instance.transactions?.map((e) => e?.toJson())?.toList(),
    };
