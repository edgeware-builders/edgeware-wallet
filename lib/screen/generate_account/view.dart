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
          const Input(hintText: 'Name'),
          SizedBox(height: 8.h),
          const Input(hintText: 'Password'),
          SizedBox(height: 8.h),
          const Input(hintText: 'Password again'),
          SizedBox(height: 15.h),
          const Expanded(child: SizedBox()),
          Button(
            text: 'Continue',
            onPressed: () {
              // TODO(shekohex): generate account
            },
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
