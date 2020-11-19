import 'package:edgeware/edgeware.dart';
import 'package:wallet/wallet.dart';

class SplashController extends GetxController {
  final _secureStorage = Get.find<SecureStorage>();
  final _edgeware = Get.find<Edgeware>();
  @override
  Future<void> onReady() async {
    super.onReady();
    final hasEntropy = await _secureStorage.hasEntropy();
    try {
      await _edgeware
          .initRpcClient(url: testNetRpcEndpoint)
          .timeout(10.seconds);
    } catch (e) {
      showErrorSnackBar(message: e.message ?? e.toString());
    }
    if (hasEntropy) {
      // ignore: unawaited_futures
      Get.offAllNamed(Routes.home);
    } else {
      // ignore: unawaited_futures
      Get.offAllNamed(Routes.intro);
    }
  }
}
