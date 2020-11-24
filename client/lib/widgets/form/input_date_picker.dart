import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

typedef FormCallback<T> = void Function(T newValue);

class InputDatePickerFormField extends StatefulWidget {
  InputDatePickerFormField({
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.validator,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.onSaved,
  });

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final FormFieldValidator<DateTime> validator;
  final InputDecoration decoration;
  final ValueChanged<DateTime> onChanged;
  final FormFieldSetter<DateTime> onSaved;

  @override
  _InputDatePickerFormFieldState createState() =>
      _InputDatePickerFormFieldState();
}

class _InputDatePickerFormFieldState extends State<InputDatePickerFormField> {
  TextEditingController _controller;
  DateFormat _dateFormat;

  DateTime get currentValue => _dateFormat.parse(_controller.text);

  DateTime _firstDate;
  DateTime _lastDate;

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
      _dateFormat = DateFormat(
        AppLocalizations.of(context).formDatePickerDateFormat,
      );

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
          ),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () async {
            final d = await showDatePicker(
              context: context,
              initialDate: currentValue,
              firstDate: _firstDate,
              lastDate: _lastDate,
            );

            if (d != null && d != currentValue) {
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
