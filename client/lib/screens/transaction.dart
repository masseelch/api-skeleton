import 'package:client/dialogs/loading.dart';
import 'package:client/generated/client/transaction.dart';
import 'package:client/widgets/form/tag_selector_form_field.dart';
import 'package:flutter/material.dart' hide InputDatePickerFormField;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../generated/client/tag.dart';
import '../generated/client/user.dart';
import '../generated/model/account.dart';
import '../generated/model/tag.dart';
import '../generated/model/transaction.dart';
import '../services/token.dart';
import '../utils/money.dart';
import '../utils/validate.dart';
import '../widgets/form/async_dropdown.dart';
import '../widgets/form/date.dart';
import '../widgets/form/money.dart';

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

  Future<List<Account>> _accounts$;
  Future<List<Tag>> _tags$;

  Transaction _transaction;

  @override
  void initState() {
    super.initState();

    _accounts$ = TokenService().getUser().then(UserClient.of(context).accounts);
    _tags$ = TagClient.of(context).list();

    _transaction = widget.transaction ?? Transaction()
      ..date = DateTime.now()
      ..edges = TransactionEdges();
  }

  @override
  Widget build(BuildContext context) {
    final focus = FocusScope.of(context);
    final t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _transaction.id == null
              ? t.screenTransactionTitleAdd
              : t.screenTransactionTitleEdit,
        ),
      ),
      persistentFooterButtons: [
        FlatButton.icon(
          label: Text(t.appActionSave), // todo - make all dates utc + createRequest edges have to be primaryKey or server has to take objects instead of ids
          icon: const Icon(Icons.save),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();

              showLoadingDialog(context);

              try {
                Transaction transaction;
                if (_transaction.id == null) {
                  transaction = await TransactionClient.of(context).create(
                    TransactionCreateRequest.fromTransaction(_transaction)
                      ..user = await TokenService.of(context).getUser(),
                  );
                } else {
                  transaction = await TransactionClient.of(context).update(
                    TransactionUpdateRequest.fromTransaction(_transaction),
                  );
                }

                Navigator.pop(context);
                Navigator.pop(context, transaction);
              } catch (e, t) {
                Navigator.pop(context);
                rethrow;
                // todo - error handling
              }
            }
          },
        ),
      ],
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            AsyncDropdownButtonFormField<Account>(
              future: _accounts$,
              itemBuilder: (acc) {
                return DropdownMenuItem<Account>(
                  value: acc,
                  child: Text(acc.title),
                );
              },
              value: _transaction.edges.account,
              onSaved: (acc) => _transaction.edges.account = acc,
              decoration: InputDecoration(
                labelText: t.screenTransactionFormAccountLabel,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: Validate().notNull(),
            ),
            MoneyFormField(
              initialValue: _transaction.amount,
              decoration: InputDecoration(
                labelText: t.screenTransactionFormAmountLabel,
              ),
              onSaved: (v) => _transaction.amount = v,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: Validate<Money>().notNull().greaterThan(
                    0,
                    errorText: t.screenTransactionFormAmountError,
                  ),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              initialValue: _transaction.title,
              decoration: InputDecoration(
                labelText: t.screenTransactionFormTitleLabel,
              ),
              onSaved: (v) => _transaction.title = v,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: Validate().notEmpty(),
              textInputAction: TextInputAction.next,
            ),
            DateFormField(
              firstDate: DateTime(2010),
              lastDate: DateTime(2100),
              initialDate: _transaction.date,
              onSaved: (v) => _transaction.date = v,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: Validate().notNull(),
              textInputAction: TextInputAction.next,
            ),
            TagSelectorFormField(
              tags: _tags$,
              initialValue: _transaction.edges.tags,
              decoration: InputDecoration(labelText: t.screenTagsTitle),
              onSaved: (v) => _transaction.edges.tags = v,
              onChanged: (v) {
                print(v);
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: Validate<List<Tag>>().minLength(
                1,
                errorText: t.screenTransactionFormTagsError,
              ),
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
