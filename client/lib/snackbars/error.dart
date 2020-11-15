import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showErrorSnackBar(
  BuildContext context, {
  String content,
  ScaffoldState scaffold,
}) {
  assert(Scaffold.of(context, nullOk: true) != null || scaffold != null);

  (Scaffold.of(context, nullOk: true) ?? scaffold).removeCurrentSnackBar();
  (Scaffold.of(context, nullOk: true) ?? scaffold).showSnackBar(
    SnackBar(
      content: Text(content ?? AppLocalizations.of(context).snackbarErrorContent),
      backgroundColor: Theme.of(context).errorColor,
    ),
  );
}
