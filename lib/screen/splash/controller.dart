import 'package:wallet/wallet.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    1.seconds.delay(() => Get.offNamed(Routes.intro));
  }
}
