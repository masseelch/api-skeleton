import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../generated/model/account.dart';
import '../generated/model/transaction.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({
    this.account,
    this.transaction,
  });

  final Account account;
  final Transaction transaction;

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _formKey = GlobalKey<FormState>();

  Transaction _transaction;

  @override
  void initState() {
    super.initState();

    _transaction = widget.transaction ?? Transaction()
      ..date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _transaction.id == null
              ? t.screenTransactionTitleAdd
              : t.screenTransactionTitleEdit,
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          children: [
            DropdownButtonFormField(
              items: [],
              onChanged: (v) {},
            ),
            InputDatePickerFormField(
              firstDate: DateTime(2010),
              lastDate: DateTime(2100),
              initialDate: _transaction.date,
              onDateSaved: (v) => _transaction.date = v,
              errorFormatText: t.screenTransactionFormDateError,
            ),
          ] // Wrap all items with some padding.
              .map((child) => Padding(
                    child: child,
                    padding: EdgeInsets.all(12),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
