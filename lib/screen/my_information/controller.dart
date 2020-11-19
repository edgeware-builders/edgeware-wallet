import 'package:flutter/cupertino.dart';
import 'package:wallet/wallet.dart';

class MyInformationController extends GetxController
    with EdgewareAccountInfoMixin {
  TextEditingController fullnameController;
  @override
  void onInit() {
    super.onInit();
    fullnameController = TextEditingController(text: fullname.value);
  }

  @override
  void onClose() {
    fullnameController.dispose();
    super.onClose();
  }

  void updateFullname() {
    pref.fullname.val = fullnameController.text.trim();
    fullname.value = fullnameController.text.trim();
    Get.back();
  }
}
