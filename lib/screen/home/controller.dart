import 'package:intl/intl.dart';
import 'package:wallet/wallet.dart';

class HomeController extends GetxController {
  final _numberFormat = NumberFormat.compactCurrency(
    decimalDigits: 0,
    symbol: 'EDG',
    name: 'EDG',
    locale: 'en',
  );

  final tokens = '0'.obs;
  final tokensFormated = '0'.obs;

  void updateTokens(String value) {
    if (value.isNullOrBlank) {
      tokens.value = '0';
      tokensFormated.value = '0';
    } else {
      tokens.value = value;
      tokensFormated.value = _numberFormat.format(int.parse(tokens.value));
    }
  }
}
