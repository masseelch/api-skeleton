import 'package:flutter/material.dart';

void showErrorSnackBar(
  BuildContext context, {
  String content,
  ScaffoldState scaffold,
}) {
  assert(Scaffold.of(context, nullOk: true) != null || scaffold != null);

  (Scaffold.of(context, nullOk: true) ?? scaffold).removeCurrentSnackBar();
  (Scaffold.of(context, nullOk: true) ?? scaffold).showSnackBar(
    SnackBar(
      content: Text(content ?? 'Fehler'),
      //BaseLocalizations.of(context).feedbackErrorSnackBarContent),
      backgroundColor: Theme.of(context).errorColor,
    ),
  );
}
