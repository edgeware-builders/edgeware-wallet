import 'package:wallet/wallet.dart';

class SplashController extends GetxController {
  final _secureStorage = Get.find<SecureStorage>();
  @override
  Future<void> onReady() async {
    super.onReady();
    final hasEntropy = await _secureStorage.hasEntropy();
    if (hasEntropy) {
      // ignore: unawaited_futures
      Get.offAllNamed(Routes.home);
    } else {
      // ignore: unawaited_futures
      Get.offAllNamed(Routes.intro);
    }
  }
}
