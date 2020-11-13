// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../model/account.dart';
import '../model/user.dart';
import '../client/user.dart';
import '../model/transaction.dart';
import '../client/transaction.dart';

const accountUrl = 'accounts';

class AccountClient {
  AccountClient({@required this.dio}) : assert(dio != null);

  final Dio dio;

  Future<Account> find(int id) async {
    final r = await dio.get('/$accountUrl/$id');
    return Account.fromJson(r.data);
  }

  Future<List<Account>> list({
    int page,
    int itemsPerPage,
    String title,
  }) async {
    final params = const {};

    if (page != null) {
      params['page'] = page;
    }

    if (itemsPerPage != null) {
      params['itemsPerPage'] = itemsPerPage;
    }

    if (title != null) {
      params['title'] = title;
    }

    final r = await dio.get('/$accountUrl');

    if (r.data == null) {
      return [];
    }

    return (r.data as List).map((i) => Account.fromJson(i)).toList();
  }

  Future<Account> create(Account e) async {
    final r = await dio.post('/$accountUrl', data: e.toJson());
    return (Account.fromJson(r.data));
  }

  Future<Account> update(Account e) async {
    final r = await dio.patch('/$accountUrl', data: e.toJson());
    return (Account.fromJson(r.data));
  }

  Future<List<User>> users(Account e) async {
    final r = await dio.get('/$accountUrl/${e.id}/$userUrl');
    return (r.data as List).map((i) => User.fromJson(i)).toList();
  }

  Future<List<Transaction>> transactions(Account e) async {
    final r = await dio.get('/$accountUrl/${e.id}/$transactionUrl');
    return (r.data as List).map((i) => Transaction.fromJson(i)).toList();
  }

  static AccountClient of(BuildContext context) =>
      Provider.of<AccountClient>(context, listen: false);
}
