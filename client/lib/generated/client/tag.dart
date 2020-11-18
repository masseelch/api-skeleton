// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../model/tag.dart';
import '../model/transaction.dart';
import '../client/transaction.dart';

const tagUrl = 'tags';

class TagClient {
  TagClient({@required this.dio}) : assert(dio != null);

  final Dio dio;

  Future<Tag> find(int id) async {
    final r = await dio.get('/$tagUrl/$id');
    return Tag.fromJson(r.data);
  }

  Future<List<Tag>> list({
    int page,
    int itemsPerPage,
    String title,
    Color color,
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

    if (color != null) {
      params['color'] = color;
    }

    final r = await dio.get('/$tagUrl');

    if (r.data == null) {
      return [];
    }

    return (r.data as List).map((i) => Tag.fromJson(i)).toList();
  }

  Future<Tag> create(Tag e) async {
    final r = await dio.post('/$tagUrl', data: e.toJson());
    return (Tag.fromJson(r.data));
  }

  Future<Tag> update(Tag e) async {
    final r = await dio.patch('/$tagUrl', data: e.toJson());
    return (Tag.fromJson(r.data));
  }

  Future<List<Transaction>> transactions(Tag e) async {
    final r = await dio.get('/$tagUrl/${e.id}/$transactionUrl');
    return (r.data as List).map((i) => Transaction.fromJson(i)).toList();
  }

  static TagClient of(BuildContext context) =>
      Provider.of<TagClient>(context, listen: false);
}
