import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_de.dart';

class Validate<T> {
  factory Validate({
    AppLocalizations localizations,
    List<FormFieldValidator<T>> fns = const [],
  }) {
    assert(fns != null);

    return Validate<T>._inner(localizations ?? AppLocalizationsDe(), fns);
  }

  Validate._inner(
    AppLocalizations localizations,
    List<FormFieldValidator<T>> fns,
  )   : _localizations = localizations,
        _fns = fns;

  final AppLocalizations _localizations;

  final List<FormFieldValidator<T>> _fns;

  String call(T v) {
    for (final f in _fns) {
      final e = f(v);

      if (e == null) continue;

      return e;
    }

    return null;
  }

  Validate<T> add(FormFieldValidator<T> fn) =>
      Validate<T>._inner(_localizations, [..._fns, fn]);

  Validate<T> notNull([String msg]) {
    final err = msg ?? _localizations.validationErrorRequired;

    return add((v) {
      if (v != null) return null;

      return err;
    });
  }

  Validate<T> notEmpty([String msg]) {
    final err = msg ?? _localizations.validationErrorRequired;

    return add((v) {
      if (v == null) return err;

      switch (v.runtimeType) {
        case List:
          return (v as List).isEmpty ? err : null;

        case String:
          return (v as String).isEmpty ? err : null;

        case int:
        case double:
          return v == 0 ? err : null;

        default:
          throw UnimplementedError();
      }
    });
  }
}
