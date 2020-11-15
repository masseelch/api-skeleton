import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../generated/client/account.dart';
import '../generated/model/account.dart';
import '../generated/model/transaction.dart';
import '../utils/num_extensions.dart';
import '../widgets/drawer.dart';
import '../widgets/progress_indicators.dart';

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
    final theme = Theme.of(context);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: Text(t.screenTransactionsTitle)),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: theme.primaryColor,
      //   foregroundColor: theme.colorScheme.onPrimary,
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     // do stuff
      //   },
      // ),
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

          final dateFormat = DateFormat.yMd(t.localeName).add_jm();

          return ListView.separated(
            itemCount: snapshot.data.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final transaction = snapshot.data[index];

              return ListTile(
                title: Text(dateFormat.format(transaction.date)),
                subtitle: Text(
                  transaction.amount.toMoneyDisplay(),
                  textAlign: TextAlign.right,
                  style: const TextStyle().copyWith(
                    color: theme.accentColor,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
