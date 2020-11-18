import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

void showInfoSnackBar({@required String message, String title}) {
  Get.snackbar(
    title,
    message,
    snackStyle: SnackStyle.GROUNDED,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.black,
    barBlur: 0,
    borderRadius: 0,
    backgroundColor: AppColors.lightBackround,
  );
}

void showErrorSnackBar({@required String message, String title}) {
  Get.snackbar(
    title ?? 'Error',
    message,
    snackStyle: SnackStyle.GROUNDED,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    barBlur: 0,
    borderRadius: 0,
    backgroundColor: AppColors.danger,
  );
}
