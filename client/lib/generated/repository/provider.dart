// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'account.dart';
import 'session.dart';
import 'tag.dart';
import 'transaction.dart';
import 'user.dart';

typedef PrefixFn = String Function(String prefix);

class GeneratedRepositoryProvider extends SingleChildStatelessWidget {
  GeneratedRepositoryProvider({
    Key key,
    @required this.dio,
    this.prefixFn = _defaultPrefixFn,
    this.child,
  })  : assert(dio != null),
        assert(prefixFn != null),
        super(key: key, child: child);

  final Dio dio;
  final PrefixFn prefixFn;
  final Widget child;

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return MultiProvider(
      providers: [
        Provider<AccountRepository>(
          create: (_) => AccountRepository(dio: dio, url: prefixFn('accounts')),
        ),
        Provider<SessionRepository>(
          create: (_) => SessionRepository(dio: dio, url: prefixFn('sessions')),
        ),
        Provider<TagRepository>(
          create: (_) => TagRepository(dio: dio, url: prefixFn('tags')),
        ),
        Provider<TransactionRepository>(
          create: (_) =>
              TransactionRepository(dio: dio, url: prefixFn('transactions')),
        ),
        Provider<UserRepository>(
          create: (_) => UserRepository(dio: dio, url: prefixFn('users')),
        ),
      ],
      child: child,
    );
  }
}

String _defaultPrefixFn(String url) => url;
