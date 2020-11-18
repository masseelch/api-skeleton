// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';

import 'dart:ui';
import '../../utils/json_converter.dart';

import '../model/user.dart';

part 'session.g.dart';

@JsonSerializable()
class Session {
  Session();

  dynamic id;
  DateTime idleTimeExpiredAt;
  DateTime lifeTimeExpiredAt;

  SessionEdges edges;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
  Map<String, dynamic> toJson() => _$SessionToJson(this);
}

@JsonSerializable()
class SessionEdges {
  SessionEdges();

  User user;

  factory SessionEdges.fromJson(Map<String, dynamic> json) =>
      _$SessionEdgesFromJson(json);
  Map<String, dynamic> toJson() => _$SessionEdgesToJson(this);
}
