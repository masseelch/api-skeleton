// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';

import '../model/user.dart';

import '../model/account.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  Transaction();

  int id;
  DateTime date;

  int amount;

  TransactionEdges edges;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

@JsonSerializable()
class TransactionEdges {
  TransactionEdges();

  User user;

  Account account;

  factory TransactionEdges.fromJson(Map<String, dynamic> json) =>
      _$TransactionEdgesFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionEdgesToJson(this);
}
