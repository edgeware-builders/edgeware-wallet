import 'dart:convert';

import 'package:wallet/wallet.dart';

class GenerateAccountController extends GetxController
    with EdgewareAccountMixin {
  Future<void> generate() async {
    try {
      loading.value = true;
      final valid = validateForAccountGeneration();
      if (!valid) {
        return;
      }
      final password = password1Controller.text.trim();
      final name = nameController.text.trim();
      final keypair = edgeware.generateKeyPair(password);
      await secureStorage.writePassword(password);
      await secureStorage.writeEntropy(base64Encode(keypair.expose()));
      pref.fullname.val = name;
      pref.address.val = keypair.public;
      showInfoSnackBar(
        title: 'Welcome',
        message: '$name (${addressFormat(keypair.public)})',
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
