// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:provider/provider.dart';

import 'dart:ui';
import '../../utils/json_converter/color.dart';
import '../../utils/money.dart';
import '../../utils/json_converter/money.dart';

import '../model/transaction.dart';
import '../model/user.dart';
import '../client/user.dart';
import '../model/account.dart';
import '../client/account.dart';
import '../model/tag.dart';
import '../client/tag.dart';

part 'transaction.g.dart';

const transactionUrl = 'transactions';

class TransactionClient {
  TransactionClient({@required this.dio}) : assert(dio != null);

  final Dio dio;

  Future<Transaction> find(int id) async {
    final r = await dio.get('/$transactionUrl/$id');
    return Transaction.fromJson(r.data);
  }

  Future<List<Transaction>> list({
    int page,
    int itemsPerPage,
    DateTime date,
    Money amount,
    String title,
  }) async {
    final params = const {};

    if (page != null) {
      params['page'] = page;
    }

    if (itemsPerPage != null) {
      params['itemsPerPage'] = itemsPerPage;
    }

    if (date != null) {
      params['date'] = date;
    }

    if (amount != null) {
      params['amount'] = amount;
    }

    if (title != null) {
      params['title'] = title;
    }

    final r = await dio.get('/$transactionUrl');

    if (r.data == null) {
      return [];
    }

    return (r.data as List).map((i) => Transaction.fromJson(i)).toList();
  }

  Future<Transaction> create(TransactionCreateRequest req) async {
    final r = await dio.post('/$transactionUrl', data: req.toJson());
    return (Transaction.fromJson(r.data));
  }

  Future<Transaction> update(TransactionUpdateRequest req) async {
    final r = await dio.patch('/$transactionUrl/${req.id}', data: req.toJson());
    return (Transaction.fromJson(r.data));
  }

  Future<User> user(Transaction e) async {
    final r = await dio.get('/$transactionUrl/${e.id}/$userUrl');
    return (User.fromJson(r.data));
  }

  Future<Account> account(Transaction e) async {
    final r = await dio.get('/$transactionUrl/${e.id}/$accountUrl');
    return (Account.fromJson(r.data));
  }

  Future<List<Tag>> tags(Transaction e) async {
    final r = await dio.get('/$transactionUrl/${e.id}/$tagUrl');
    return (r.data as List).map((i) => Tag.fromJson(i)).toList();
  }

  static TransactionClient of(BuildContext context) =>
      Provider.of<TransactionClient>(context, listen: false);
}

@JsonSerializable(createFactory: false)
class TransactionCreateRequest {
  TransactionCreateRequest({
    this.date,
    this.amount,
    this.title,
    this.user,
    this.account,
    this.tags,
  });

  TransactionCreateRequest.fromTransaction(Transaction e)
      : date = e.date,
        amount = e.amount,
        title = e.title,
        user = e.edges?.user,
        account = e.edges?.account,
        tags = e.edges?.tags;

  DateTime date;
  @MoneyConverter()
  Money amount;
  String title;
  User user;
  Account account;
  List<Tag> tags;

  Map<String, dynamic> toJson() => _$TransactionCreateRequestToJson(this);
}

@JsonSerializable(createFactory: false)
class TransactionUpdateRequest {
  TransactionUpdateRequest({
    this.id,
    this.date,
    this.amount,
    this.title,
    this.user,
    this.account,
    this.tags,
  });

  TransactionUpdateRequest.fromTransaction(Transaction e)
      : id = e.id,
        date = e.date,
        amount = e.amount,
        title = e.title,
        user = e.edges?.user,
        account = e.edges?.account,
        tags = e.edges?.tags;

  int id;
  DateTime date;
  @MoneyConverter()
  Money amount;
  String title;
  User user;
  Account account;
  List<Tag> tags;

  Map<String, dynamic> toJson() => _$TransactionUpdateRequestToJson(this);
}
