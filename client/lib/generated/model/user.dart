// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'dart:ui';
import '../../utils/json_converter/color.dart';
import '../../utils/money.dart';
import '../../utils/json_converter/money.dart';

import '../model/session.dart';
import '../model/account.dart';
import '../model/transaction.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User();

  int id;
  String email;
  String password;
  bool enabled;
  String firstName;
  String lastName;

  UserEdges edges;

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is User && id == other.id;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  String toString() => jsonEncode(toJson());
}

@JsonSerializable()
class UserEdges {
  UserEdges();

  List<Session> sessions;
  List<Account> accounts;
  List<Transaction> transactions;

  factory UserEdges.fromJson(Map<String, dynamic> json) =>
      _$UserEdgesFromJson(json);
  Map<String, dynamic> toJson() => _$UserEdgesToJson(this);
}
