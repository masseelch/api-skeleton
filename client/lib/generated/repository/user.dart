// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class UserRepository {
  UserRepository({
    @required this.dio,
    @required this.url,
  })  : assert(dio != null),
        assert(url != null && url != '');

  final Dio dio;
  final String url;

  Future<User> find(int id) async {
    final r = await dio.get('/$url/$id');
    return User.fromJson(r.data);
  }

  Future<List<User>> list({
    int page,
    int itemsPerPage,
    String email,
    String password,
    bool enabled,
  }) async {
    final params = const {};

    if (page != null) {
      params['page'] = page;
    }

    if (itemsPerPage != null) {
      params['itemsPerPage'] = itemsPerPage;
    }

    if (email != null) {
      params['email'] = email;
    }

    if (password != null) {
      params['password'] = password;
    }

    if (enabled != null) {
      params['enabled'] = enabled;
    }

    final r = await dio.get('/$url');

    if (r.data == null) {
      return [];
    }

    return (r.data as List).map((i) => User.fromJson(i)).toList();
  }

  Future<User> create(User e) async {
    final r = await dio.post('/$url', data: e.toJson());
    return (User.fromJson(r.data));
  }

  Future<User> update(User e) async {
    final r = await dio.patch('/$url', data: e.toJson());
    return (User.fromJson(r.data));
  }

  static UserRepository of(BuildContext context) =>
      Provider.of<UserRepository>(context, listen: false);
}
