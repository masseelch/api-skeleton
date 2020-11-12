import 'package:flutter/material.dart';

Future showFeedbackDialog(
  BuildContext context, {
  String title,
  String content,
}) {
  // final t = BaseLocalizations.of(context);

  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title ?? 'Achtung'),
      //t.feedbackDialogTitle),
      content: Text(content ?? 'Es ist ein Fehler aufgetreten'),
      //t.feedbackDialogContent),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          child: Text('OK'), //t.feedbackDialogOkLabel),
        )
      ],
    ),
  );
}
