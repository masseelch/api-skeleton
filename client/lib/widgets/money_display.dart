import 'package:flutter/material.dart';

import '../utils/money.dart';

class MoneyDisplay extends StatelessWidget {
  const MoneyDisplay(this.money);

  final Money money;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      (money.value / 100).toStringAsFixed(2) + ' €',
      textAlign: TextAlign.right,
      style: theme.textTheme.headline5.copyWith(
        color: theme.accentColor,
      ),
    );
  }
}
