// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../model/session.dart';
import '../model/user.dart';

class SessionClient {
  SessionClient({@required this.dio}) : assert(dio != null);

  final Dio dio;

  Future<Session> find(String id) async {
    final r = await dio.get('/sessions/$id');
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

    final r = await dio.get('/sessions');

    if (r.data == null) {
      return [];
    }

    return (r.data as List).map((i) => Session.fromJson(i)).toList();
  }

  Future<Session> create(Session e) async {
    final r = await dio.post('/sessions', data: e.toJson());
    return (Session.fromJson(r.data));
  }

  Future<Session> update(Session e) async {
    final r = await dio.patch('/sessions', data: e.toJson());
    return (Session.fromJson(r.data));
  }

  Future<User> user(Session e) async {
    final r = await dio.get('/sessions/${e.id}/user');
    return (User.fromJson(r.data));
  }

  static SessionClient of(BuildContext context) =>
      Provider.of<SessionClient>(context, listen: false);
}
