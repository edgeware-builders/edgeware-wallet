import 'package:edgeware/edgeware.dart';
import 'package:wallet/wallet.dart';

class AppBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(Edgeware());
  }
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

class MeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MeController());
  }
}

class MyInformationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MeController());
  }
}

class ContactsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ContactsController());
  }
}

class SettingsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingsController());
  }
}

class TransferBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TransferController());
  }
}
