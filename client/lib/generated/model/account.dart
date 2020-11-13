// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';

import '../model/user.dart';

import '../model/transaction.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  Account();

  int id;
  String title;

  AccountEdges edges;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

@JsonSerializable()
class AccountEdges {
  AccountEdges();

  List<User> users;

  List<Transaction> transactions;

  factory AccountEdges.fromJson(Map<String, dynamic> json) =>
      _$AccountEdgesFromJson(json);
  Map<String, dynamic> toJson() => _$AccountEdgesToJson(this);
}
