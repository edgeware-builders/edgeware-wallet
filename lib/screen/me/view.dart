import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          CircleAvatar(
            child: Text(
              nameFormat('Drew Stone'),
              style: TextStyle(fontSize: 38.ssp),
            ),
            radius: 46,
          ),
          SizedBox(height: 12.h),
          Center(
            child: Text(
              edgFormat(BigInt.parse('99999')),
              style: TextStyle(
                fontSize: 18.ssp,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
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
