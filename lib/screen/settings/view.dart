import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

class SettingsScreen extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Paper Key'),
            subtitle: const Text(
              'Show a paper key used to recover your account',
            ),
            onTap: () {
              Get.to(_PaperKeyScreen());
            },
          ),
          ListTile(
            title: const Text(
              'Delete Account',
              style: TextStyle(
                color: AppColors.danger,
              ),
            ),
            subtitle: const Text(
              'THIS WILL DESTROY EVERYTHING SAVED BY THE APPLICATION.',
            ),
            onTap: () {
              Get.snackbar(
                null,
                'Not yet implemented :)',
                snackStyle: SnackStyle.GROUNDED,
                snackPosition: SnackPosition.BOTTOM,
                colorText: Colors.black,
                barBlur: 0,
                borderRadius: 0,
                backgroundColor: AppColors.lightBackround,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PaperKeyScreen extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paper Key'),
        elevation: 0,
      ),
      body: Column(
        children: [
          const Text(
            'Write down these words in a paper and keep it somewhere safe:',
            style: TextStyle(color: Colors.black54),
            textAlign: TextAlign.start,
          ).paddingAll(8),
          TextFormField(
            readOnly: true,
            maxLines: 5,
            style: const TextStyle(color: Colors.black),
            textAlign: TextAlign.justify,
            enableInteractiveSelection: true,
            decoration: const InputDecoration(
              hintText: '...',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black87),
              ),
              hintStyle: TextStyle(
                color: Colors.black45,
              ),
              contentPadding: EdgeInsets.all(4),
            ),
          ).paddingAll(8),
          const Text(
            'a paper key can be used to access your account in case you'
            ' lost your device or uninstalled the app.'
            ' Keep one in a safe place '
            '(like a wallet) to keep your data safe.',
            style: TextStyle(color: Colors.black54),
            textAlign: TextAlign.start,
          ).paddingAll(8),
          const Expanded(child: SizedBox()),
          Button(
            text: 'Done',
            onPressed: () {
              Get.back();
            },
            textColor: AppColors.primary,
            variant: ButtonVariant.outline,
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
