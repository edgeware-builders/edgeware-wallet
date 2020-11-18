import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

class GenerateAccountScreen extends GetView<GenerateAccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate account'),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          Center(
            child: Text(
              'Generate new account',
              style: TextStyle(fontSize: 22.ssp),
            ),
          ),
          SizedBox(height: 15.h),
          Obx(
            () => Input(
              hintText: 'Name',
              controller: controller.nameController,
              errorText: controller.nameError.value,
              onChanged: (_) {
                controller.nameError.value = '';
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
                controller.password2Error.value = '';
              },
            ),
          ),
          SizedBox(height: 8.h),
          Obx(
            () => Input(
              hintText: 'Password again',
              obscureText: true,
              controller: controller.password2Controller,
              errorText: controller.password2Error.value,
              onChanged: (_) {
                controller.password1Error.value = '';
                controller.password2Error.value = '';
              },
            ),
          ),
          SizedBox(height: 15.h),
          const Expanded(child: SizedBox()),
          Obx(
            () => Button(
              text: 'Continue',
              onPressed: () {
                controller.generate();
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
