import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

class RecoverAccountScreen extends GetView<RecoverAccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recover account'),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          Center(
            child: Text(
              'Recover your account',
              style: TextStyle(fontSize: 22.ssp),
            ),
          ),
          SizedBox(height: 15.h),
          Obx(
            () => Input(
              hintText: 'cute asthma joy knee trade strong '
                  'satisfy muffin doctor acoustic maple battle',
              maxLines: 4,
              controller: controller.paperKeyController,
              errorText: controller.paperKeyError.value,
              onChanged: (_) {
                controller.paperKeyError.value = '';
              },
            ),
          ),
          SizedBox(height: 8.h),
          Obx(
            () => Input(
              hintText: 'Password',
              obscureText: true,
              controller: controller.password1Controller,
              errorText: controller.password1Error.value,
              onChanged: (_) {
                controller.password1Error.value = '';
              },
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Password must be the same used to generate this account, '
              'otherwise it will generate a completitly different one.',
              style: TextStyle(
                fontSize: 14.ssp,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          const Expanded(child: SizedBox()),
          Button(
            text: 'Continue',
            onPressed: () {
              controller.recover();
            },
            enabled: true, // we should disable it while recovering.
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
