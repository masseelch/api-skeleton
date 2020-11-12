import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static const _tokenKey = 'api-skeleton-token';
  // static const _tokenLifeExpiredAtKey = 'api-skeleton-token-life-expired-at'

  Future<String> getToken() async =>
      (await SharedPreferences.getInstance()).getString(_tokenKey);

  Future<bool> setToken(String t) async =>
      (await SharedPreferences.getInstance()).setString(_tokenKey, t);

  static TokenService of(BuildContext context) =>
      Provider.of<TokenService>(context, listen: false);
}
