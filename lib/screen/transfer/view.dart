import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet/wallet.dart';

class TransferScreen extends GetView<TransferController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                'Who you want to send ${controller.op.amount} EDG?',
                style: TextStyle(
                  fontSize: 18.ssp,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Input(
            prefixIcon: SvgPicture.asset(
              'assets/svg/search.svg',
              fit: BoxFit.scaleDown,
            ),
            hintText: 'Search or type new address',
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.contacts.length,
                shrinkWrap: true,
                primary: true,
                itemBuilder: (context, index) {
                  final contact = controller.contacts[index];
                  return ContactTile(
                    name: contact.fullname,
                    address: contact.address,
                    trailingText: 'SEND',
                    trailingOnPressed: () {
                      // TODO(shekohex): do the transaction here
                      Get.offAll(
                        _TransactionSuccess(
                          name: contact.fullname,
                          address: contact.address,
                          amount: controller.op.amount,
                          currentBalance: BigInt.parse(
                            controller.currentBalance.value,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.lightBackround,
        child: Image.asset(
          'assets/png/qr.png',
          fit: BoxFit.scaleDown,
          width: 28.w,
        ),
        onPressed: () {},
      ),
    );
  }
}

class _TransactionSuccess extends StatelessWidget {
  const _TransactionSuccess({
    @required this.name,
    @required this.amount,
    @required this.address,
    @required this.currentBalance,
    Key key,
  }) : super(key: key);
  final String name, address;
  final BigInt amount, currentBalance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // ignore: unawaited_futures
        Get.offAllNamed(Routes.home);
        return true;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 170.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                'You Sent $name',
                style: TextStyle(
                  fontSize: 26.ssp,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            const Expanded(child: SizedBox()),
            TokensValue(edgFormat(amount)),
            SizedBox(height: 8.h),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                'EDG $amount',
                style: TextStyle(
                  fontSize: 14.ssp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                'Your current balance: ${edgFormat(currentBalance)}',
                style: TextStyle(
                  fontSize: 14.ssp,
                  color: Colors.black45,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            SizedBox(height: 8.h),
            Button(
              text: 'Back',
              onPressed: () {
                Get.offAllNamed(Routes.home);
              },
              textColor: AppColors.primary,
              variant: ButtonVariant.outline,
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}

class _TransactionFailed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class TransferOperation {
  TransferOperation({
    @required this.amount,
  });
  final BigInt amount;
}
