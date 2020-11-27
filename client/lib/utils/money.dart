class Money {
  Money(this._value) : assert(_value != null);

  Money.fromDouble(double v) : _value = (v * 100).toInt();

  final int _value;

  int get value => _value;

  double toDouble() => _value / 100;

  Money operator +(Money other) {
    return Money(value + (other?.value ?? 0));
  }
}