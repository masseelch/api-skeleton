// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable()
class Session {
  Session();

  String id;
  DateTime idleTimeExpiredAt;

  DateTime lifeTimeExpiredAt;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
