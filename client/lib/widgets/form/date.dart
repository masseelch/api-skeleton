import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

typedef FormCallback<T> = void Function(T newValue);

class DateFormField extends StatefulWidget {
  DateFormField({
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.onSaved,
    this.validator,
    this.autovalidateMode,
    this.textInputAction,
    this.onEditingComplete,
  });

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final InputDecoration decoration;
  final ValueChanged<DateTime> onChanged;
  final FormFieldSetter<DateTime> onSaved;
  final FormFieldValidator<DateTime> validator;
  final AutovalidateMode autovalidateMode;
  final TextInputAction textInputAction;
  final VoidCallback onEditingComplete;

  @override
  _DateFormFieldState createState() => _DateFormFieldState();
}

class _DateFormFieldState extends State<DateFormField> {
  TextEditingController _controller;
  DateFormat _dateFormat;

  DateTime get currentValue => _dateFormat.parseLoose(_controller.text);

  DateTime _firstDate;
  DateTime _lastDate;

  AppLocalizations t;

  @override
  void initState() {
    super.initState();

    _firstDate = widget.firstDate ?? DateTime(2000);
    _lastDate = widget.lastDate ?? DateTime(2100);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_controller == null) {
      t = AppLocalizations.of(context);

      _dateFormat = DateFormat(t.formDatePickerDateFormat);

      _controller = TextEditingController(
        text: _dateFormat.format(widget.initialDate ?? DateTime.now()),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextFormField(
            controller: _controller,
            decoration: widget.decoration,
            onSaved: _cb(widget.onSaved),
            onChanged: _cb(widget.onChanged),
            autovalidateMode: widget.autovalidateMode,
            textInputAction: widget.textInputAction,
            onEditingComplete: widget.onEditingComplete,
            validator: (v) {
              if (v == null || v.isEmpty) {
                return widget.validator?.call(null);
              }

              try {
                final d = _dateFormat.parseLoose(v);

                if (d.isBefore(_firstDate)) {
                  return t.formDatePickerDateBeforeError(_firstDate);
                }

                if (d.isAfter(_lastDate)) {
                  return t.formDatePickerDateAfterError(_lastDate);
                }

                return widget.validator?.call(_dateFormat.parseLoose(v));
              } catch (_) {
                return t.formDatePickerDateFormatError;
              }
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () async {
            FocusScope.of(context).unfocus();
            DateTime old;

            try {
              old = currentValue;
            } catch (_) {
              old = DateTime.now();
            }

            final d = await showDatePicker(
              context: context,
              initialDate: old,
              firstDate: _firstDate,
              lastDate: _lastDate,
            );

            if (d != null && d != old) {
              widget.onChanged?.call(d);
              setState(() {
                _controller.text = _dateFormat.format(d);
              });
            }
          },
        ),
      ],
    );
  }

  FormCallback<String> _cb(FormCallback<DateTime> cb) {
    if (cb != null) {
      return (v) {
        try {
          cb(_dateFormat.parseLoose(v));
        } catch (_) {}
      };
    }

    return null;
  }
}
