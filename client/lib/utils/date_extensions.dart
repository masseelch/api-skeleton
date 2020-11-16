extension DateExtensions on DateTime {
  DateTime startOfMonth() => DateTime(this.year, this.month);

  DateTime endOfMonth() => DateTime(this.year, this.month + 1, 0);

  bool isSameMonth(DateTime other) =>
      this.year == other.year && this.month == other.month;
}
