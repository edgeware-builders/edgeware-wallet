import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wallet/wallet.dart';

class MeScreen extends GetView<MeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              Get.bottomSheet(
                ShareAccount(
                  fullname: controller.fullname.value,
                  address: controller.address,
                ),
                enableDrag: true,
                isDismissible: true,
                useRootNavigator: false,
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          CircleAvatar(
            child: Obx(
              () => Text(
                nameFormat(controller.fullname.value),
                style: TextStyle(fontSize: 38.ssp),
              ),
            ),
            radius: 46,
          ),
          SizedBox(height: 12.h),
          Center(
            child: Obx(
              () => Text(
                edgFormat(BigInt.parse(controller.currentBalance.value)),
                style: TextStyle(
                  fontSize: 18.ssp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          _SectionItem(
            svgPath: 'assets/svg/profile.svg',
            title: 'My Information',
            onPressed: () {
              Get.toNamed(Routes.myInformation);
            },
          ),
          SizedBox(height: 8.h),
          _SectionItem(
            svgPath: 'assets/svg/contacts.svg',
            title: 'Contacts',
            onPressed: () {
              Get.toNamed(Routes.myContacts);
            },
          ),
          SizedBox(height: 8.h),
          _SectionItem(
            svgPath: 'assets/svg/settings.svg',
            title: 'Settings',
            onPressed: () {
              Get.toNamed(Routes.settings);
            },
          ),
          SizedBox(height: 8.h),
          _SectionItem(
            svgPath: 'assets/svg/legal.svg',
            title: 'Legal & Policies',
            onPressed: () {
              Get.toNamed(Routes.legal);
            },
          ),
        ],
      ),
    );
  }
}

class ShareAccount extends StatelessWidget {
  const ShareAccount({
    @required this.fullname,
    @required this.address,
    Key key,
  }) : super(key: key);
  final String fullname, address;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 22.h),
          Center(
              child: Text(
            fullname,
            style: TextStyle(fontSize: 22.ssp),
          )),
          SizedBox(height: 8.h),
          Center(
            child: QrImage(
              data: encodeAccountQr(
                AccountQr(fullname, address),
              ),
              version: QrVersions.auto,
              size: 300.w,
            ),
          ),
          SizedBox(height: 8.h),
          Center(
              child: Text(
            addressFormat(address),
            style: TextStyle(
              fontSize: 16.ssp,
              color: AppColors.disabled,
            ),
          )),
        ],
      ),
    );
  }
}

class _SectionItem extends StatelessWidget {
  const _SectionItem({
    @required this.svgPath,
    @required this.title,
    @required this.onPressed,
    this.subTitle,
    this.enabled = true,
    Key key,
  }) : super(key: key);

  final String svgPath;
  final String title;
  final String subTitle;
  final void Function() onPressed;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return const SizedBox();
    } else {
      return FlatButton(
        onPressed: onPressed,
        height: 64.h,
        highlightColor: Colors.black12,
        splashColor: Colors.black12,
        child: Row(
          children: [
            SvgPicture.asset(
              svgPath,
              fit: BoxFit.scaleDown,
            ),
            SizedBox(width: 8.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.ssp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (subTitle != null)
                  Text(
                    subTitle,
                    style: TextStyle(
                      color: AppColors.disabled,
                      fontSize: 12.ssp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
