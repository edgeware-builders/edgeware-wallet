import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/png/logo.png', height: 25.h),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: const CircleAvatar(
            backgroundColor: AppColors.primary,
            child: Text('DS'),
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 45.h),
          Obx(() => _TokensValue(controller.tokensFormated.value)),
          SizedBox(height: 4.h.toDouble()),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Obx(
              () => Text(
                '${controller.tokens} EDG',
                style: TextStyle(
                  fontSize: 14.ssp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          const Expanded(child: SizedBox()),
          Numpad(
            length: 18,
            onChange: (v) {
              controller.updateTokens(v);
            },
          ),
          SizedBox(height: 30.h.toDouble()),
          Button(
            text: 'Send',
            textColor: Colors.black,
            onPressed: () {},
            variant: ButtonVariant.outline,
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}

class _TokensValue extends StatelessWidget {
  const _TokensValue(String value) : _value = value;
  final String _value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: FittedBox(
          child: Text(
            _value,
            style: TextStyle(
              fontSize: 68.ssp,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
            ),
          ),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
