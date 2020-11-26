import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_de.dart';

import 'money.dart';

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

  Validate<T> notNull({String errorText}) {
    final err = errorText ?? _localizations.validationErrorRequired;

    return add((v) {
      if (v != null) return null;

      return err;
    });
  }

  Validate<T> notEmpty({String errorText}) {
    final err = errorText ?? _localizations.validationErrorRequired;

    return add((v) {
      if (v == null) return err;

      if (v is List) {
        return v.isEmpty ? err : null;
      }

      if (v is String) {
        return v.isEmpty ? err : null;
      }

      if (v is num) {
        return v == 0 ? err : null;
      }

      throw UnimplementedError();
    });
  }

  Validate<T> greaterThan(num amount, {String errorText}) {
    final err =
        errorText ?? _localizations.validationErrorGreater(amount.toString());

    return add((v) {
      if (v == null) return null;

      if (v is num) {
        return v <= amount ? err : null;
      }

      if (v is Money) {
        return v.value <= amount ? err : null;
      }

      print(v.runtimeType);
      throw UnimplementedError();
    });
  }

  Validate<T> minLength(num length, {String errorText}) {
    final err =
        errorText ?? _localizations.validationErrorMinLength(length.toString());

    return add((v) {
      if (v == null) return null;

      if (v is Iterable) {
        return v.length < length ? err : null;
      }

      if (v is Map) {
        return v.length < length ? err : null;
      }
      print(v.runtimeType);
      throw UnimplementedError();
    });
  }
}
