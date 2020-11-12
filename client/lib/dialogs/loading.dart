import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context, [String text]) => showDialog(
  context: context,
  builder: (BuildContext context) => WillPopScope(
    onWillPop: () async => false,
    child: LoadingDialog(text),
  ),
  barrierDismissible: false,
);

void hideLoadingDialog(BuildContext context) =>
    Navigator.of(context, rootNavigator: true).pop();

class LoadingDialog extends StatelessWidget {
  const LoadingDialog([this.text]);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CircularProgressIndicator(),
            Text(text ?? 'Lade ...'), // BaseLocalizations.of(context).feedbackLoadingDialogContent),
          ],
        ),
      ),
    );
  }
}
