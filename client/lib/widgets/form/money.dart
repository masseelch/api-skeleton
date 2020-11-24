import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../../utils/money.dart';

typedef FormCallback<T> = void Function(T newValue);

class MoneyFormField extends StatefulWidget {
  MoneyFormField({
    this.initialValue,
    this.focusNode,
    this.textInputAction,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.enabled,
    this.keyboardAppearance,
    this.autovalidateMode,
    this.decoration = const InputDecoration(),
    this.autofocus = false,
  });

  final Money initialValue;
  final FocusNode focusNode;
  final InputDecoration decoration;
  final TextInputAction textInputAction;
  final bool autofocus;
  final ValueChanged<Money> onChanged;
  final GestureTapCallback onTap;
  final VoidCallback onEditingComplete;
  final ValueChanged<Money> onFieldSubmitted;
  final FormFieldSetter<Money> onSaved;
  final FormFieldValidator<Money> validator;
  final bool enabled;
  final Brightness keyboardAppearance;
  final AutovalidateMode autovalidateMode;

  @override
  _MoneyFormFieldState createState() => _MoneyFormFieldState();
}

class _MoneyFormFieldState extends State<MoneyFormField> {
  MoneyMaskedTextController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_controller == null) {
      final t = AppLocalizations.of(context);

      _controller = MoneyMaskedTextController(
        decimalSeparator: t.formMoneyDecimalSeparator,
        thousandSeparator: t.formMoneyThousandSeparator,
        rightSymbol: t.formMoneyRightSymbol,
        leftSymbol: t.formMoneyLeftSymbol,
        initialValue: widget.initialValue?.toDouble() ?? 0,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      focusNode: widget.focusNode,
      decoration: widget.decoration,
      textInputAction: widget.textInputAction,
      autofocus: widget.autofocus,
      onChanged: _cb(widget.onChanged),
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: _cb(widget.onFieldSubmitted),
      onSaved: _cb(widget.onSaved),
      validator: widget.validator == null
          ? null
          : (_) => widget.validator(Money.fromDouble(_controller.numberValue)),
      enabled: widget.enabled,
      keyboardAppearance: widget.keyboardAppearance,
      autovalidateMode: widget.autovalidateMode,
      keyboardType: TextInputType.number,
    );
  }

  FormCallback<String> _cb(FormCallback<Money> cb) {
    if (cb != null) {
      return (_) => cb(Money.fromDouble(_controller.numberValue));
    }

    return null;
  }
}
