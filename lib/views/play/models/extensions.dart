extension LogExtension on (int, int) {
  (int, int) operator -() => (-($1 + 1), -$2);
}
