import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet/wallet.dart';

class ContactsScreen extends GetView<ContactsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 11,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Input(
                    prefixIcon: SvgPicture.asset(
                      'assets/svg/search.svg',
                      fit: BoxFit.scaleDown,
                    ),
                    hintText: 'Search',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: IconButton(
                    icon: Image.asset(
                      'assets/png/qr.png',
                      fit: BoxFit.scaleDown,
                    ),
                    splashRadius: 25,
                    onPressed: () {},
                  ),
                ),
              ],
            );
          } else {
            return ContactTile(
              name: 'Shady Khalifa',
              address: '5FPATeYHZTiYsFq3iZ8gtxzTKoDaYfHhFZAynah3wfzkyFEH',
              onPressed: () {},
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add a Contact',
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.person_add),
        onPressed: () {},
      ),
    );
  }
}

class ContactTile extends StatelessWidget {
  const ContactTile({
    @required this.name,
    @required this.address,
    this.color = AppColors.primary,
    this.trailingText = 'VIEW',
    this.onPressed,
    Key key,
  }) : super(key: key);

  final String name, address;
  final Color color;
  final String trailingText;
  final FutureOr<void> Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          nameFormat(name),
          style: TextStyle(fontSize: 18.ssp),
        ),
        radius: 22.w,
      ),
      title: Text(name),
      subtitle: Text(addressFormat(address)),
      trailing: FlatButton(
        child: Text(trailingText),
        textColor: AppColors.primary,
        onPressed: onPressed,
      ),
    );
  }
}
