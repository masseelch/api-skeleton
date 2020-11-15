import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../client/extensions.dart';
import '../generated/client/account.dart';
import '../generated/model/account.dart';
import '../services/token.dart';
import '../utils/date_extensions.dart';
import '../utils/num_extensions.dart';
import '../widgets/drawer.dart';
import '../widgets/list_header.dart';
import '../widgets/progress_indicators.dart';
import 'transactions.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<List<Account>> _accounts$;

  @override
  void initState() {
    super.initState();

    TokenService.of(context).getUser().then((user) {
      setState(() {
        final now = DateTime.now();
        _accounts$ = AccountClient.of(context).meta(
          user,
          from: now.startOfMonth(),
          to: now.endOfMonth(),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final drawer = const AppDrawer();
    final appBar = AppBar(title: Text(t.screenDashboardTitle));

    if (_accounts$ == null) {
      return Scaffold(
        drawer: drawer,
        appBar: appBar,
        body: const Center(child: const CircularProgressIndicator()),
      );
    }

    final dateFormat = DateFormat.MMMM(t.localeName);

    return Scaffold(
      drawer: drawer,
      appBar: appBar,
      body: FutureBuilder<List<Account>>(
        future: _accounts$,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CenteredCircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Container();
            // todo - handle error
          }

          final children = <Widget>[
            ListHeader(t.screenDashboardListHeader(
              dateFormat.format(DateTime.now()),
            )),
          ];

          children.addAll(ListTile.divideTiles(
            context: context,
            tiles: snapshot.data.map((acc) {
              final expenses = acc.edges.transactions.fold<int>(
                0,
                (previousValue, element) => previousValue + element.amount,
              );

              return ListTile(
                title: Text(acc.title),
                subtitle: Text(
                  expenses.toMoneyDisplay(),
                  textAlign: TextAlign.right,
                  style: const TextStyle().copyWith(
                    color: theme.accentColor,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TransactionsScreen(account: acc),
                  ));
                },
              );
            }),
          ));

          return ListView(children: children);
        },
      ),
    );
  }
}
