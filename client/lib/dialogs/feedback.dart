import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future showFeedbackDialog(
  BuildContext context, {
  String title,
  String content,
}) {
  final t = AppLocalizations.of(context);

  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title ?? t.dialogFeedbackTitle),
      content: Text(content ?? t.dialogFeedbackContent),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          child: Text(t.appActionOK),
        )
      ],
    ),
  );
}
