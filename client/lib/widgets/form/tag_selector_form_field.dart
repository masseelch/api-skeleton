import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_select/smart_select.dart';

import '../../generated/model/tag.dart';
import '../tag_display.dart';
import '../trailing_circular_progress_indicator.dart';

class TagSelectorFormField extends FormField<List<Tag>> {
  TagSelectorFormField({
    Key key,
    @required this.tags,
    List<Tag> initialValue,
    InputDecoration decoration = const InputDecoration(),
    FormFieldSetter<List<Tag>> onSaved,
    ValueChanged<List<Tag>> onChanged,
    FormFieldValidator<List<Tag>> validator,
    AutovalidateMode autovalidateMode,
  })  : assert(tags != null),
        super(
          key: key,
          initialValue: initialValue ?? [],
          validator: validator,
          onSaved: onSaved,
          autovalidateMode: autovalidateMode,
          builder: (state) {
            final field = state as _TagSelectorFormFieldState;
            final t = AppLocalizations.of(field.context);

            final effectiveDecoration = (decoration ?? const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme)
                .copyWith(
                  hintText: decoration.hintText ?? decoration.labelText,
                  errorText: field.errorText,
                );

            final onChangedHandler = (List<Tag> v) {
              field.didChange(v);
              onChanged?.call(v);
            };

            return FutureBuilder<List<Tag>>(
              future: field._tags$,
              initialData: [],
              builder: (context, snapshot) {
                return SmartSelect<Tag>.multiple(
                  title: t.formSmartSelectDefaultTitle,
                  value: field.value,
                  onChange: (state) {
                    onChangedHandler(state.value);
                  },
                  modalConfirm: true,
                  modalType: S2ModalType.bottomSheet,
                  choiceLayout: S2ChoiceLayout.wrap,
                  choiceItems: S2Choice.listFrom<Tag, Tag>(
                    source: snapshot.data,
                    value: (_, item) => item,
                    title: (_, item) => item.title,
                  ),
                  choiceBuilder: (_, choice, __) {
                    return TagDisplay(
                      tag: choice.value,
                      chipStyle: ChipStyle.selectable,
                      selected: choice.selected,
                      onSelected: (selected) => choice.select(selected),
                    );
                  },
                  tileBuilder: (context, state) {
                    return InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();

                        state.showModal();
                      },
                      child: InputDecorator(
                        isEmpty: field.value == null || field.value.isEmpty,
                        decoration: effectiveDecoration,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Wrap(
                                spacing: 12,
                                children: state.valueObject.map((choice) {
                                  return TagDisplay(
                                    tag: choice.value,
                                    onDeleted: () {
                                      FocusScope.of(context).unfocus();

                                      onChangedHandler(
                                        field.value..remove(choice.value),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                            if (snapshot.connectionState ==
                                ConnectionState.waiting)
                              const TrailingCircularProgressIndicator(),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );

  final FutureOr<List<Tag>> tags;

  @override
  _TagSelectorFormFieldState createState() => _TagSelectorFormFieldState();
}

class _TagSelectorFormFieldState extends FormFieldState<List<Tag>> {
  Future<List<Tag>> _tags$;

  @override
  TagSelectorFormField get widget => super.widget as TagSelectorFormField;

  @override
  void initState() {
    super.initState();

    _tags$ = Future.value(widget.tags);
  }
}
