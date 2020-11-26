// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'dart:ui';
import '../../utils/json_converter/color.dart';
import '../../utils/money.dart';
import '../../utils/json_converter/money.dart';

import '../model/user.dart';

part 'session.g.dart';

@JsonSerializable()
class Session {
  Session();

  dynamic id;
  DateTime idleTimeExpiredAt;
  DateTime lifeTimeExpiredAt;

  SessionEdges edges;

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Session && id == other.id;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
  Map<String, dynamic> toJson() => _$SessionToJson(this);

  String toString() => jsonEncode(toJson());
}

@JsonSerializable()
class SessionEdges {
  SessionEdges();

  User user;

  factory SessionEdges.fromJson(Map<String, dynamic> json) =>
      _$SessionEdgesFromJson(json);
  Map<String, dynamic> toJson() => _$SessionEdgesToJson(this);
}
