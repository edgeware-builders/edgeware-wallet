import 'dart:convert';

import 'package:wallet/wallet.dart';

class RecoverAccountController extends GetxController
    with EdgewareAccountMixin {
  Future<void> recover() async {
    try {
      loading.value = true;
      final valid = validateForAccountRecover();
      if (!valid) {
        return;
      }
      final password = password1Controller.text.trim();
      final phrase = paperKeyController.text.trim();
      final keypair = edgeware.restoreKeyPair(phrase, password);
      await secureStorage.writePassword(password);
      await secureStorage.writeEntropy(base64Encode(keypair.expose()));
      pref.address.val = keypair.public;
      showInfoSnackBar(
        title: 'Welcome',
        message: '(${addressFormat(keypair.public)})',
      );
      await Future.delayed(1.seconds);
      // ignore: unawaited_futures
      Get.offAllNamed(Routes.home);
    } catch (e) {
      print(e);
      showErrorSnackBar(
        message: '${e.message ?? e.toString()}',
      );
    } finally {
      loading.value = false;
    }
  }
}
