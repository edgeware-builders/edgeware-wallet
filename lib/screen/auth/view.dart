import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

import 'controller.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 8.h),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Enter you password to authenticate',
                style: TextStyle(
                  fontSize: 22.ssp,
                ),
              ),
            ),
          ),
          Obx(
            () => Input(
              hintText: 'Password',
              controller: controller.passwordController,
              errorText: controller.passwordError.value,
              obscureText: true,
              onChanged: (_) {
                controller.passwordError.value = '';
              },
            ),
          ),
          SizedBox(height: 15.h),
          const Expanded(child: SizedBox()),
          Obx(
            () => Button(
              text: 'Authenticate',
              onPressed: () {
                controller.authenticatePassword();
              },
              enabled: !controller.loading.value,
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
