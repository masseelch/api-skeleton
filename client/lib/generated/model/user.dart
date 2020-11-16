// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';

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

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
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
