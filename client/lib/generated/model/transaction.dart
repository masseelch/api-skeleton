// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';

import 'dart:ui';
import '../../utils/json_converter/color.dart';
import '../../utils/money.dart';
import '../../utils/json_converter/money.dart';

import '../model/user.dart';
import '../model/account.dart';
import '../model/tag.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  Transaction();

  int id;
  DateTime date;
  @MoneyConverter()
  Money amount;
  String title;

  TransactionEdges edges;

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Transaction && id == other.id;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

@JsonSerializable()
class TransactionEdges {
  TransactionEdges();

  User user;
  Account account;
  List<Tag> tags;

  factory TransactionEdges.fromJson(Map<String, dynamic> json) =>
      _$TransactionEdgesFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionEdgesToJson(this);
}
