import 'package:edgeware/edgeware.dart';
import 'package:flutter/cupertino.dart';
import 'package:wallet/wallet.dart';

class SettingsController extends GetxController {
  final edgeware = Get.find<Edgeware>();
  TextEditingController paperkeyController;
  @override
  void onInit() {
    super.onInit();
    paperkeyController = TextEditingController(text: '...');
  }

  @override
  void onReady() {
    super.onReady();
    final pharse = edgeware.backupKeyPair();
    paperkeyController.text = pharse;
  }

  @override
  void onClose() {
    paperkeyController.dispose();
    super.onClose();
  }
}
