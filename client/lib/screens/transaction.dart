import 'package:client/widgets/tag_display.dart';
import 'package:flutter/material.dart' hide InputDatePickerFormField;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_select/smart_select.dart';

import '../generated/client/tag.dart';
import '../generated/client/user.dart';
import '../generated/model/account.dart';
import '../generated/model/tag.dart';
import '../generated/model/transaction.dart';
import '../services/token.dart';
import '../utils/money.dart';
import '../utils/validate.dart';
import '../widgets/form/async_dropdown.dart';
import '../widgets/form/input_date_picker.dart';
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
  List<S2Choice<Tag>> _tags; // todo - future-builder

  Transaction _transaction;

  @override
  void initState() {
    super.initState();

    _accounts$ = TokenService().getUser().then(UserClient.of(context).accounts);
    _tags$ = TagClient.of(context).list();
    _tags$.then((value) => setState(() {
          _tags = S2Choice.listFrom<Tag, Tag>(
            source: value,
            value: (index, item) => item,
            title: (index, item) => item.title,
          );
        }));

    _transaction = widget.transaction ?? Transaction()
      ..date = DateTime.now()
      ..edges = TransactionEdges();
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
              validator: Validate<Account>().notNull(),
            ),
            InputDatePickerFormField(
              firstDate: DateTime(2010),
              lastDate: DateTime(2100),
              initialDate: _transaction.date,
              onSaved: (v) => _transaction.date = v,
            ),
            TextFormField(
              initialValue: _transaction.title,
              decoration: InputDecoration(
                labelText: t.screenTransactionFormTitleLabel,
              ),
              onSaved: (v) => _transaction.title = v,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: Validate().notEmpty(),
            ),
            MoneyFormField(
              initialValue: _transaction.amount,
              decoration: InputDecoration(
                labelText: t.screenTransactionFormAmountLabel,
              ),
              onSaved: (v) => _transaction.amount = v,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: Validate<Money>().notNull(),
            ),
            SmartSelect<Tag>.multiple(
              title: 'Kategorien (ut)',
              value: _transaction.edges.tags,
              onChange: (state) {
                setState(() {
                  _transaction.edges.tags = state.value;
                });
              },
              choiceItems: _tags ?? [],
              choiceLayout: S2ChoiceLayout.wrap,
              choiceBuilder: (_, choice, __) {
                return TagDisplay(
                  tag: choice.value,
                  chipStyle: ChipStyle.selectable,
                  selected: choice.selected,
                  onSelected: (selected) => choice.select(selected),
                );
              },
              tileBuilder: (context, state) {
                return InkWell(
                  onTap: state.showModal,
                  child: InputDecorator(
                    isEmpty: _transaction.edges.tags == null ||
                        _transaction.edges.tags.length == 0,
                    decoration: const InputDecoration(
                      labelText: 'Kategorien (ut)',
                    ),
                    child: Wrap(
                      spacing: 12,
                      children: state.valueObject.map((choice) {
                        return TagDisplay(
                          tag: choice.value,
                          onDeleted: () {
                            setState(() {
                              _transaction.edges.tags.remove(choice.value);
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
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
