import 'package:client/screens/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../generated/client/account.dart';
import '../generated/model/account.dart';
import '../generated/model/transaction.dart';
import '../generated/model/user.dart';
import '../widgets/money_display.dart';
import '../widgets/progress_indicators.dart';
import '../widgets/tag_display.dart';

class TransactionsScreen extends StatefulWidget {
  TransactionsScreen({@required this.account}) : assert(account != null);

  final Account account;

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  Future<List<Transaction>> _transactions$;

  @override
  void initState() {
    super.initState();

    _transactions$ = AccountClient.of(context).transactions(widget.account);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.screenTransactionsTitle(widget.account.title)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final t = Navigator.push<Transaction>(
            context,
            MaterialPageRoute(
              builder: (_) => TransactionScreen(account: widget.account),
            ),
          );

          if (t != null) {
            // todo
          }
        },
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _transactions$,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CenteredCircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Container();
            // todo - handle error
          }

          return ListView.separated(
            itemCount: snapshot.data.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) => _Entry(snapshot.data[index]),
          );
        },
      ),
    );
  }
}

class _Entry extends StatelessWidget {
  _Entry(this.transaction);

  final Transaction transaction;

  User get user => transaction.edges.user;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: transaction.edges.tags
                    .map((tag) => TagDisplay(tag: tag))
                    .toList(),
                spacing: 5,
              ),
              const SizedBox(height: 10),
              Text(
                transaction.title,
                style: theme.textTheme.subtitle1,
              ),
              const SizedBox(height: 5),
              Text(
                t.screenTransactionsEntryCreator(
                  transaction.date,
                  '${user.firstName} ${user.lastName}',
                ),
                style: theme.textTheme.caption,
              ),
            ],
          ),
          MoneyDisplay(transaction.amount),
        ],
      ),
    );
  }
}
