import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/model/user.dart';

class TokenService {
  static const _tokenKey = 'token';
  static const _userKey = 'user';

  // static const _tokenLifeExpiredAtKey = 'api-skeleton-token-life-expired-at'

  Future<String> getToken() async =>
      (await SharedPreferences.getInstance()).getString(_tokenKey);

  Future<User> getUser() async => User.fromJson(
      jsonDecode((await SharedPreferences.getInstance()).getString(_userKey)));

  Future<bool> login(String t, User u) async {
    final prefs = await SharedPreferences.getInstance();
    final b1 = await prefs.setString(_tokenKey, t);
    final b2 = await prefs.setString(_userKey, jsonEncode(u.toJson()));

    return b1 && b2;
  }

  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final b1 = await prefs.remove(_tokenKey);
    final b2 = await prefs.remove(_userKey);

    return b1 && b2;
  }

  static TokenService of(BuildContext context) =>
      Provider.of<TokenService>(context, listen: false);
}
