import 'package:flutter/material.dart';

class Money extends StatelessWidget {
  const Money(this.money);

  final int money;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      (money / 100).toStringAsFixed(2) + ' €',
      textAlign: TextAlign.right,
      style: theme.textTheme.headline5.copyWith(
        color: theme.accentColor,
      ),
    );
  }
}
