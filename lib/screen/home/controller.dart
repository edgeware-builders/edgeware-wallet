import 'package:edgeware/edgeware.dart';
import 'package:wallet/wallet.dart';

class HomeController extends GetxController {
  final tokens = '0'.obs;
  final tokensFormated = '0'.obs;
  final edgeware = Get.find<Edgeware>();

  void updateTokens(String value) {
    if (value.isNullOrBlank) {
      tokens.value = '0';
      tokensFormated.value = '0';
    } else {
      tokens.value = value;
      tokensFormated.value = edgFormat(BigInt.parse(tokens.value));
    }
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    try {
      // Just to test this out
      final keypair = edgeware.generateKeyPair('123456');
      await edgeware.initRpcClient(url: testNetRpcEndpoint);
      final info = await edgeware.queryAccountInfo(ss58: keypair.public);
      print(info);
      await edgeware.balanceTransfer(
        toSs58:
            '5DobgfbJygh5p9YHU9rYhx28123hQkb6LvAFYiDCg65h2w2i', // from explorer
        amount: BigInt.from(1000),
      );
    } catch (e) {
      print(e);
    }
  }
}
