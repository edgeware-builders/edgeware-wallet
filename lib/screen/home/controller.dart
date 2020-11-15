import 'package:wallet/wallet.dart';

class HomeController extends GetxController {
  final tokens = '0'.obs;
  final tokensFormated = '0'.obs;

  void updateTokens(String value) {
    if (value.isNullOrBlank) {
      tokens.value = '0';
      tokensFormated.value = '0';
    } else {
      tokens.value = value;
      tokensFormated.value = edgFormat(BigInt.parse(tokens.value));
    }
  }
}
