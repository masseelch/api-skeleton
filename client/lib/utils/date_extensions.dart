extension DateExtensions on DateTime {
  DateTime startOfMonth() => DateTime(this.year, this.month);

  DateTime endOfMonth() => DateTime(this.year, this.month + 1, 0);
}
