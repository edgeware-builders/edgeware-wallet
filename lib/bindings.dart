import 'package:wallet/wallet.dart';

class AppBindings extends Bindings {
  @override
  Future<void> dependencies() async {}
}

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}

class IntroBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(IntroController());
  }
}
