import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {
  const ListHeader(this.header) : assert(header != null);

  final String header;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 30, bottom: 16),
      child: Text(
        header.toUpperCase(),
        style: theme.textTheme.overline.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
