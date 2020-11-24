import 'package:json_annotation/json_annotation.dart';

import '../money.dart';

class MoneyConverter implements JsonConverter<Money, int> {
  const MoneyConverter();

  @override
  Money fromJson(int json) => Money(json);

  @override
  int toJson(Money object) => object.value;
}
