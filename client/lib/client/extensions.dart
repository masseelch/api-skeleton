import 'package:flutter/foundation.dart';

import '../generated/client/account.dart';
import '../generated/client/user.dart';
import '../generated/model/account.dart';
import '../generated/model/user.dart';

extension AccountClientExtension on AccountClient {
  Future<List<Account>> meta(
    User user, {
    @required DateTime from,
    @required DateTime to,
  }) async {
    assert(user != null);
    assert(from != null);
    assert(to != null);

    final r = await dio.get(
        '/$userUrl/${user.id}/account-meta/${_formatDateTime(from)}/${_formatDateTime(to)}');
    return (r.data as List).map((i) => Account.fromJson(i)).toList();
  }
}

String _formatDateTime(DateTime d) =>
    '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
