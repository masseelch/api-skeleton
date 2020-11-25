import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showErrorSnackBar(
  BuildContext context, {
  String content,
}) {
  ScaffoldMessenger.maybeOf(context).removeCurrentSnackBar();
  ScaffoldMessenger.maybeOf(context).showSnackBar(
    SnackBar(
      content: Text(
        content ?? AppLocalizations.of(context).snackbarErrorContent,
      ),
      backgroundColor: Theme.of(context).errorColor,
    ),
  );
}
