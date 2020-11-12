// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../model/tag.dart';

class TagRepository {
  TagRepository({
    @required this.dio,
    @required this.url,
  })  : assert(dio != null),
        assert(url != null && url != '');

  final Dio dio;
  final String url;

  Future<Tag> find(int id) async {
    final r = await dio.get('/$url/$id');
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

    final r = await dio.get('/$url');

    if (r.data == null) {
      return [];
    }

    return (r.data as List).map((i) => Tag.fromJson(i)).toList();
  }

  Future<Tag> create(Tag e) async {
    final r = await dio.post('/$url', data: e.toJson());
    return (Tag.fromJson(r.data));
  }

  Future<Tag> update(Tag e) async {
    final r = await dio.patch('/$url', data: e.toJson());
    return (Tag.fromJson(r.data));
  }

  static TagRepository of(BuildContext context) =>
      Provider.of<TagRepository>(context, listen: false);
}
