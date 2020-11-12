// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../model/account.dart';

class AccountRepository {
  AccountRepository({
    @required this.dio,
    @required this.url,
  })  : assert(dio != null),
        assert(url != null && url != '');

  final Dio dio;
  final String url;

  Future<Account> find(int id) async {
    final r = await dio.get('/$url/$id');
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

    final r = await dio.get('/$url');

    if (r.data == null) {
      return [];
    }

    return (r.data as List).map((i) => Account.fromJson(i)).toList();
  }

  Future<Account> create(Account e) async {
    final r = await dio.post('/$url', data: e.toJson());
    return (Account.fromJson(r.data));
  }

  Future<Account> update(Account e) async {
    final r = await dio.patch('/$url', data: e.toJson());
    return (Account.fromJson(r.data));
  }

  static AccountRepository of(BuildContext context) =>
      Provider.of<AccountRepository>(context, listen: false);
}
