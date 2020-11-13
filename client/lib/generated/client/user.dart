// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../model/session.dart';
import '../client/session.dart';
import '../model/account.dart';
import '../client/account.dart';
import '../model/transaction.dart';
import '../client/transaction.dart';

const userUrl = 'users';

class UserClient {
  UserClient({@required this.dio}) : assert(dio != null);

  final Dio dio;

  Future<User> find(int id) async {
    final r = await dio.get('/$userUrl/$id');
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

    final r = await dio.get('/$userUrl');

    if (r.data == null) {
      return [];
    }

    return (r.data as List).map((i) => User.fromJson(i)).toList();
  }

  Future<User> create(User e) async {
    final r = await dio.post('/$userUrl', data: e.toJson());
    return (User.fromJson(r.data));
  }

  Future<User> update(User e) async {
    final r = await dio.patch('/$userUrl', data: e.toJson());
    return (User.fromJson(r.data));
  }

  Future<List<Session>> sessions(User e) async {
    final r = await dio.get('/$userUrl/${e.id}/$sessionUrl');
    return (r.data as List).map((i) => Session.fromJson(i)).toList();
  }

  Future<List<Account>> accounts(User e) async {
    final r = await dio.get('/$userUrl/${e.id}/$accountUrl');
    return (r.data as List).map((i) => Account.fromJson(i)).toList();
  }

  Future<List<Transaction>> transactions(User e) async {
    final r = await dio.get('/$userUrl/${e.id}/$transactionUrl');
    return (r.data as List).map((i) => Transaction.fromJson(i)).toList();
  }

  static UserClient of(BuildContext context) =>
      Provider.of<UserClient>(context, listen: false);
}
