import 'dart:convert';

import 'package:edgeware/edgeware.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:wallet/wallet.dart';

class AuthController extends GetxController {
  final auth = LocalAuthentication();
  final edgeware = Get.find<Edgeware>();
  final pref = Get.find<Preferences>();
  final secureStorage = Get.find<SecureStorage>();

  final loading = true.obs;
  final passwordError = ''.obs;
  final canCheckBiometrics = false.obs;

  List<BiometricType> availableBiometrics = List<BiometricType>.empty();
  TextEditingController passwordController;

  @override
  Future<void> onReady() async {
    super.onReady();
    loading.value = true;
    passwordController = TextEditingController();
    final useBiometricAuth = pref.useBiometricAuth.val;
    if (!useBiometricAuth) {
      loading.value = false;
      return; // no more work to do.
    }
    canCheckBiometrics.value = await _checkBiometrics();
    if (canCheckBiometrics.value) {
      await _getAvailableBiometrics();
      if (availableBiometrics.isNotEmpty) {
        await authenticate();
      }
    }
    loading.value = false;
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }

  Future<void> authenticate() async {
    try {
      final authenticated = await auth.authenticateWithBiometrics(
        localizedReason: 'Scan your fingerprint to authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
        sensitiveTransaction: true,
      );
      if (authenticated) {
        await _initKeyPair();
      }
    } on PlatformException catch (e) {
      print(e);
      showErrorSnackBar(message: e.message);
    }
  }

  Future<void> authenticatePassword() async {
    final pass = passwordController.text;
    if (pass.length < 8) {
      passwordError.value = 'Password must be at least 8 characters';
      return;
    }
    final mypassword = await secureStorage.readPassword();
    if (mypassword != pass) {
      passwordError.value = 'Wrong Password!';
      return;
    }
    await _initKeyPair();
  }

  Future<bool> _checkBiometrics() async {
    try {
      return auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> _getAvailableBiometrics() async {
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _initKeyPair() async {
    try {
      final password = await secureStorage.readPassword();
      final entropy = await secureStorage.readEntropy();
      edgeware.initKeyPair(base64Decode(entropy), password);
      Get.back(result: true);
    } catch (e) {
      showErrorSnackBar(message: e.message ?? e.toString());
    }
  }
}
