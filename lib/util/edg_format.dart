import 'package:intl/intl.dart';

final _edgFormat = NumberFormat.compactCurrency(
  decimalDigits: 0,
  symbol: 'EDG',
  name: 'EDG',
  locale: 'en',
);

String edgFormat(BigInt tokens) {
  return _edgFormat.format(tokens.toDouble());
}
