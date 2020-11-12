// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../model/session.dart';

class SessionRepository {
  SessionRepository({
    @required this.dio,
    @required this.url,
  })  : assert(dio != null),
        assert(url != null && url != '');

  final Dio dio;
  final String url;

  Future<Session> find(String id) async {
    final r = await dio.get('/$url/$id');
    return Session.fromJson(r.data);
  }

  Future<List<Session>> list({
    int page,
    int itemsPerPage,
    DateTime idleTimeExpiredAt,
    DateTime lifeTimeExpiredAt,
  }) async {
    final params = const {};

    if (page != null) {
      params['page'] = page;
    }

    if (itemsPerPage != null) {
      params['itemsPerPage'] = itemsPerPage;
    }

    if (idleTimeExpiredAt != null) {
      params['idleTimeExpiredAt'] = idleTimeExpiredAt;
    }

    if (lifeTimeExpiredAt != null) {
      params['lifeTimeExpiredAt'] = lifeTimeExpiredAt;
    }

    final r = await dio.get('/$url');

    if (r.data == null) {
      return [];
    }

    return (r.data as List).map((i) => Session.fromJson(i)).toList();
  }

  Future<Session> create(Session e) async {
    final r = await dio.post('/$url', data: e.toJson());
    return (Session.fromJson(r.data));
  }

  Future<Session> update(Session e) async {
    final r = await dio.patch('/$url', data: e.toJson());
    return (Session.fromJson(r.data));
  }

  static SessionRepository of(BuildContext context) =>
      Provider.of<SessionRepository>(context, listen: false);
}
