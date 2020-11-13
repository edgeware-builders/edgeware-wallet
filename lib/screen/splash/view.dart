import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

class SplashScreen extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: kDesignSize,
      allowFontScaling: true,
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          Center(
            child: SizedBox(
              width: 104.w,
              height: 258.h,
              child: Image.asset('assets/png/logo.png'),
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
