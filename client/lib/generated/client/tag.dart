// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../model/tag.dart';

class TagClient {
  TagClient({@required this.dio}) : assert(dio != null);

  final Dio dio;

  Future<Tag> find(int id) async {
    final r = await dio.get('/tags/$id');
    return Tag.fromJson(r.data);
  }

  Future<List<Tag>> list({
    int page,
    int itemsPerPage,
    String title,
    String description,
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

    if (description != null) {
      params['description'] = description;
    }

    final r = await dio.get('/tags');

    if (r.data == null) {
      return [];
    }

    return (r.data as List).map((i) => Tag.fromJson(i)).toList();
  }

  Future<Tag> create(Tag e) async {
    final r = await dio.post('/tags', data: e.toJson());
    return (Tag.fromJson(r.data));
  }

  Future<Tag> update(Tag e) async {
    final r = await dio.patch('/tags', data: e.toJson());
    return (Tag.fromJson(r.data));
  }

  static TagClient of(BuildContext context) =>
      Provider.of<TagClient>(context, listen: false);
}
