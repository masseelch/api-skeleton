import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../client/extensions.dart';
import '../generated/client/account.dart';
import '../generated/model/account.dart';
import '../services/token.dart';
import '../utils/date_extensions.dart';
import '../widgets/drawer.dart';
import '../widgets/list_header.dart';
import '../widgets/money.dart';
import '../widgets/progress_indicators.dart';
import 'transactions.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<List<Account>> _accounts$;

  DateTime _currentMonth;
  DateTime _lastMonth;

  @override
  void initState() {
    super.initState();

    _currentMonth = DateTime.now();
    _lastMonth = _currentMonth.startOfMonth().subtract(const Duration(days: 1));

    TokenService.of(context).getUser().then((user) {
      setState(() {
        final now = DateTime.now();
        _accounts$ = AccountClient.of(context).meta(
          user,
          from: now.startOfMonth().subtract(Duration(days: 1)).startOfMonth(),
          to: now.endOfMonth(),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

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

          return ListView(
            children: [
              ListHeader(t.screenDashboardListHeader(
                dateFormat.format(_currentMonth),
              )),
              ...ListTile.divideTiles(
                context: context,
                tiles: snapshot.data.map(
                  (acc) => _AccountTile(
                    account: acc,
                    month: _currentMonth,
                  ),
                ),
              ),
              ListHeader(t.screenDashboardListHeader(
                dateFormat.format(_lastMonth),
              )),
              ...ListTile.divideTiles(
                context: context,
                tiles: snapshot.data.map(
                  (acc) => _AccountTile(
                    account: acc,
                    month: _lastMonth,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AccountTile extends StatefulWidget {
  _AccountTile({this.account, this.month});

  final Account account;
  final DateTime month;

  @override
  __AccountTileState createState() => __AccountTileState();
}

class __AccountTileState extends State<_AccountTile> {
  int _expenses;

  @override
  void initState() {
    super.initState();

    _expenses = widget.account.edges.transactions
        .where((t) => !t.date.isSameMonth(widget.month))
        .fold<int>(0, (p, e) => p + e.amount);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TransactionsScreen(account: widget.account),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.account.title,
                  style: theme.textTheme.subtitle1,
                ),
              ],
            ),
            Money(_expenses),
          ],
        ),
      ),
    );
  }
}
