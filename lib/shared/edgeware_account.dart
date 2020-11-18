import 'package:edgeware/edgeware.dart';
import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

mixin EdgewareAccountMixin on GetxController {
  final edgeware = Get.find<Edgeware>();
  final secureStorage = Get.find<SecureStorage>();
  final pref = Get.find<Preferences>();

  final loading = false.obs;
  final nameError = ''.obs;
  final paperKeyError = ''.obs;
  final password1Error = ''.obs;
  final password2Error = ''.obs;

  TextEditingController nameController;
  TextEditingController paperKeyController;
  TextEditingController password1Controller;
  TextEditingController password2Controller;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    paperKeyController = TextEditingController();
    password1Controller = TextEditingController();
    password2Controller = TextEditingController();
  }

  @override
  void onClose() {
    nameController.dispose();
    paperKeyController.dispose();
    password1Controller.dispose();
    password2Controller.dispose();
    super.onClose();
  }

  bool validateForAccountGeneration() {
    final name = nameController.text.trim();
    final pass1 = password1Controller.text.trim();
    final pass2 = password2Controller.text.trim();
    var valid = true;
    if (name.isEmpty) {
      nameError.value = 'What is your name?';
      valid = false;
    }
    if (pass1.length < 8) {
      password1Error.value = 'Password must be at least 8 characters';
      valid = false;
    }
    if (pass2.length < 8) {
      password2Error.value = 'Password must be at least 8 characters';
      valid = false;
    }
    if (pass1 != pass2) {
      password2Error.value = 'Passwords must match!';
      valid = false;
    }
    return valid;
  }

  bool validateForAccountRecover() {
    final paperKey = paperKeyController.text.trim();
    final pass1 = password1Controller.text.trim();
    var valid = true;
    if (paperKey.isEmpty || paperKey.split(' ').length != 12) {
      paperKeyError.value = 'Please check your paper key (seed phrase)';
      valid = false;
    }
    if (pass1.length < 8) {
      password1Error.value = 'Password must be at least 8 characters';
      valid = false;
    }
    return valid;
  }
}
