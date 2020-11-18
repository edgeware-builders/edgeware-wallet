import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/png/logo.png', height: 25.h),
        centerTitle: true,
        leading: Obx(() => _Me(name: controller.fullname.value)),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 45.h),
          Obx(() => TokensValue(controller.tokensFormated.value)),
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
          Obx(
            () => Button(
              text: 'Send',
              textColor: Colors.black,
              enabled: controller.tokens.value != '0',
              onPressed: () {
                controller.doWalletTransfer();
              },
              variant: ButtonVariant.outline,
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}

class _Me extends StatelessWidget {
  const _Me({
    Key key,
    this.name,
  }) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: GestureDetector(
        child: CircleAvatar(
          child: Text(
            nameFormat(name),
            style: TextStyle(fontSize: 16.ssp),
          ),
        ),
        onTap: () => Get.toNamed(Routes.me),
      ),
    );
  }
}

class TokensValue extends StatelessWidget {
  const TokensValue(String value) : _value = value;
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
