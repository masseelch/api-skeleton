import '../generated/client/account.dart';
import '../generated/model/account.dart';

extension AccountClientExtension on AccountClient {
  Future<List<Account>> meta() async {
    final r = await dio.get('/$accountUrl/meta');
    return (r.data as List).map((i) => Account.fromJson(i)).toList();
  }
}