import 'package:flutter/material.dart';

typedef ItemBuilder<T> = DropdownMenuItem<T> Function(T item);

class AsyncDropdownButtonFormField<T> extends StatefulWidget {
  AsyncDropdownButtonFormField({
    @required this.future,
    @required this.itemBuilder,
    this.selectedItemBuilder,
    this.value,
    this.hint,
    this.disabledHint,
    this.onChanged,
    this.onTap,
    this.elevation = 8,
    this.style,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24.0,
    this.isDense = true,
    this.isExpanded = false,
    this.itemHeight,
    this.focusColor,
    this.focusNode,
    this.autofocus = false,
    this.dropdownColor,
    this.decoration = const InputDecoration(),
    this.onSaved,
    this.validator,
    this.autovalidateMode,
  })  : assert(future != null),
        assert(itemBuilder != null),
        assert(onSaved != null || onChanged != null);

  final Future<List<T>> future;
  final DropdownButtonBuilder selectedItemBuilder;
  final ItemBuilder<T> itemBuilder;
  final T value;
  final Widget hint;
  final Widget disabledHint;
  final ValueChanged<T> onChanged;
  final VoidCallback onTap;
  final int elevation;
  final TextStyle style;
  final Widget icon;
  final Color iconDisabledColor;
  final Color iconEnabledColor;
  final double iconSize;
  final bool isDense;
  final bool isExpanded;
  final double itemHeight;
  final Color focusColor;
  final FocusNode focusNode;
  final bool autofocus;
  final Color dropdownColor;
  final InputDecoration decoration;
  final FormFieldSetter<T> onSaved;
  final FormFieldValidator<T> validator;
  final AutovalidateMode autovalidateMode;

  @override
  _AsyncDropdownButtonFormFieldState<T> createState() =>
      _AsyncDropdownButtonFormFieldState<T>();
}

class _AsyncDropdownButtonFormFieldState<T>
    extends State<AsyncDropdownButtonFormField<T>> {
  Future<List<T>> _items$;

  @override
  void initState() {
    super.initState();

    _items$ = widget.future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: _items$,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return DropdownButtonFormField<T>(
            icon: const AspectRatio(
              aspectRatio: 1,
              child: const CircularProgressIndicator(
                strokeWidth: 2.5,
              ),
            ),
            items: [],
            onChanged: widget.onChanged,
            hint: widget.hint,
            disabledHint: widget.disabledHint,
            elevation: widget.elevation,
            style: widget.style,
            iconDisabledColor: widget.iconDisabledColor,
            iconEnabledColor: widget.iconEnabledColor,
            iconSize: widget.iconSize,
            isDense: widget.isDense,
            isExpanded: widget.isExpanded,
            itemHeight: widget.itemHeight,
            focusColor: widget.focusColor,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            dropdownColor: widget.dropdownColor,
            decoration: widget.decoration,
          );
        }

        if (snapshot.hasError) {
          // todo - handle
          throw snapshot.error;
        }

        return DropdownButtonFormField<T>(
          items: snapshot.data
              .map<DropdownMenuItem<T>>(widget.itemBuilder)
              .toList(),
          selectedItemBuilder: widget.selectedItemBuilder,
          value: widget.value,
          hint: widget.hint,
          disabledHint: widget.disabledHint,
          onChanged: widget.onChanged ?? widget.onSaved,
          onTap: widget.onTap,
          elevation: widget.elevation,
          style: widget.style,
          icon: widget.icon,
          iconDisabledColor: widget.iconDisabledColor,
          iconEnabledColor: widget.iconEnabledColor,
          iconSize: widget.iconSize,
          isDense: widget.isDense,
          isExpanded: widget.isExpanded,
          itemHeight: widget.itemHeight,
          focusColor: widget.focusColor,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          dropdownColor: widget.dropdownColor,
          decoration: widget.decoration,
          onSaved: widget.onSaved,
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode,
        );
      },
    );
  }
}
