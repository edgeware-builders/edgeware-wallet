import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

class IntroScreen extends GetView<IntroController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          Center(
            child: SizedBox(
              width: 250.w,
              height: 250.h,
              child: Image.asset(
                'assets/png/logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            'Edgeware',
            style: TextStyle(fontSize: 42.ssp),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Wallet',
                style: TextStyle(fontSize: 32.ssp),
              ),
              Text(
                'beta',
                style: TextStyle(fontSize: 11.ssp),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          Button(
            text: 'Generate new account',
            onPressed: () {},
          ),
          SizedBox(height: 20.h),
          Button(
            text: 'Recover my account',
            textColor: Colors.black,
            variant: ButtonVariant.outline,
            onPressed: () {},
          ),
          SizedBox(height: 20.h),
          Text(
            '© Commonwealth Labs ${DateTime.now().year}',
            style: TextStyle(
              fontSize: 14.ssp,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
