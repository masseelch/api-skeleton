// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../model/transaction.dart';

class TransactionRepository {
  TransactionRepository({
    @required this.dio,
    @required this.url,
  })  : assert(dio != null),
        assert(url != null && url != '');

  final Dio dio;
  final String url;

  Future<Transaction> find(int id) async {
    final r = await dio.get('/$url/$id');
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

    final r = await dio.get('/$url');

    if (r.data == null) {
      return [];
    }

    return (r.data as List).map((i) => Transaction.fromJson(i)).toList();
  }

  Future<Transaction> create(Transaction e) async {
    final r = await dio.post('/$url', data: e.toJson());
    return (Transaction.fromJson(r.data));
  }

  Future<Transaction> update(Transaction e) async {
    final r = await dio.patch('/$url', data: e.toJson());
    return (Transaction.fromJson(r.data));
  }

  static TransactionRepository of(BuildContext context) =>
      Provider.of<TransactionRepository>(context, listen: false);
}
