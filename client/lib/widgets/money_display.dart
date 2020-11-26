import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/money.dart';

class MoneyDisplay extends StatelessWidget {
  const MoneyDisplay(this.money);

  final Money money;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context);

    return Text(
      t.appFormatMoney(money.value / 100),
      textAlign: TextAlign.right,
      style: theme.textTheme.headline5.copyWith(
        color: theme.accentColor,
      ),
    );
  }
}
