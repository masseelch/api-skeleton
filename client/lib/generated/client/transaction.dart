// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../model/transaction.dart';
import '../model/user.dart';
import '../client/user.dart';
import '../model/account.dart';
import '../client/account.dart';

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
    int amount,
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

    final r = await dio.get('/$transactionUrl');

    if (r.data == null) {
      return [];
    }

    return (r.data as List).map((i) => Transaction.fromJson(i)).toList();
  }

  Future<Transaction> create(Transaction e) async {
    final r = await dio.post('/$transactionUrl', data: e.toJson());
    return (Transaction.fromJson(r.data));
  }

  Future<Transaction> update(Transaction e) async {
    final r = await dio.patch('/$transactionUrl', data: e.toJson());
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

  static TransactionClient of(BuildContext context) =>
      Provider.of<TransactionClient>(context, listen: false);
}
