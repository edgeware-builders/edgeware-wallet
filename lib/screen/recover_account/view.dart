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
          const Input(
            hintText: 'cute asthma joy knee trade strong '
                'satisfy muffin doctor acoustic maple battle',
            maxLines: 4,
          ),
          SizedBox(height: 8.h),
          const Input(hintText: 'Password'),
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
              // TODO(shekohex): recover account
            },
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
