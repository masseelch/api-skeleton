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

class ClientProvider extends SingleChildStatelessWidget {
  ClientProvider({
    Key key,
    @required this.dio,
    this.child,
  })  : assert(dio != null),
        super(key: key, child: child);

  final Dio dio;
  final Widget child;

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return MultiProvider(
      providers: [
        Provider<AccountClient>(
          create: (_) => AccountClient(dio: dio),
        ),
        Provider<TagClient>(
          create: (_) => TagClient(dio: dio),
        ),
        Provider<TransactionClient>(
          create: (_) => TransactionClient(dio: dio),
        ),
        Provider<UserClient>(
          create: (_) => UserClient(dio: dio),
        ),
      ],
      child: child,
    );
  }
}
