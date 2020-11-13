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

class GenerateAccountBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(GenerateAccountController());
  }
}

class RecoverAccountBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(RecoverAccountController());
  }
}

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
