import 'package:edgeware/edgeware.dart';
import 'package:flutter/cupertino.dart';
import 'package:wallet/wallet.dart';

class SettingsController extends GetxController {
  final edgeware = Get.find<Edgeware>();
  final pref = Get.find<Preferences>();

  final useBiometricAuth = true.obs;
  TextEditingController paperkeyController;
  @override
  void onInit() {
    super.onInit();
    useBiometricAuth.value = pref.useBiometricAuth.val;
    paperkeyController = TextEditingController(text: '...');
  }

  @override
  void onClose() {
    paperkeyController.dispose();
    super.onClose();
  }

  Future<bool> loadPaperKey() async {
    final authorized = await Get.to(
      AuthScreen(),
      fullscreenDialog: true,
      popGesture: true,
      transition: Transition.downToUp,
    );
    if (authorized != null && authorized) {
      final pharse = edgeware.backupKeyPair();
      paperkeyController.text = pharse;
      edgeware.cleanKeyPair();
      return true;
    } else {
      showErrorSnackBar(message: 'authorization failed!', title: 'Auth Error');
      await Future.delayed(2.seconds);
      return false;
    }
  }

  void changeBiometricAuth({bool value = true}) {
    useBiometricAuth.value = value;
    pref.useBiometricAuth.val = value;
  }
}
