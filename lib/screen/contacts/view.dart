import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet/wallet.dart';

class ContactsScreen extends GetView<ContactsController> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.contacts.clear();
        await controller.loadContacts();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contacts'),
          elevation: 0,
        ),
        body: Obx(
          () {
            final contacts = controller.contacts;
            if (contacts.isEmpty) {
              return const EmptyContactsSubView();
            }
            return ListView.builder(
              itemCount: contacts.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const _SearchBar();
                } else {
                  final contact = contacts[index - 1];
                  return ContactTile(
                    name: contact.fullname,
                    address: contact.address,
                    onTap: () {
                      Get.bottomSheet(
                        ContactInformationSheet(contact: contact),
                        enableDrag: true,
                        isDismissible: true,
                        useRootNavigator: false,
                      );
                    },
                    onLongPress: () {
                      Get.bottomSheet(
                        ShareAccount(
                          fullname: contact.fullname,
                          address: contact.address,
                        ),
                        enableDrag: true,
                        isDismissible: true,
                        useRootNavigator: false,
                      );
                    },
                    trailingOnPressed: () {
                      Get.bottomSheet(
                        ContactInformationSheet(contact: contact),
                        enableDrag: true,
                        isDismissible: true,
                        useRootNavigator: false,
                      );
                    },
                  );
                }
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add a Contact',
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.person_add),
          onPressed: () async {
            final contact = await Get.bottomSheet(
              const _AddNewContactSheet(),
              enableDrag: true,
              isDismissible: true,
              useRootNavigator: false,
            );
            await controller.saveContact(contact);
          },
        ),
      ),
    );
  }
}

class _SearchBar extends GetView<ContactsController> {
  const _SearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              controller.scanContactQr();
            },
          ),
        ),
      ],
    );
  }
}

class ContactTile extends StatelessWidget {
  const ContactTile({
    @required this.name,
    @required this.address,
    this.color = AppColors.primary,
    this.trailingText = 'VIEW',
    this.onTap,
    this.trailingOnPressed,
    this.onLongPress,
    Key key,
  }) : super(key: key);

  final String name, address;
  final Color color;
  final String trailingText;
  final FutureOr<void> Function() onTap;
  final FutureOr<void> Function() onLongPress;
  final FutureOr<void> Function() trailingOnPressed;
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
        onPressed: trailingOnPressed,
      ),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}

class ContactInformationSheet extends GetView<ContactsController> {
  const ContactInformationSheet({
    @required this.contact,
    Key key,
  }) : super(key: key);
  final Contact contact;
  @override
  Widget build(BuildContext context) {
    controller.queryContactBalance(contact);
    return Container(
      color: Colors.white,
      height: 280.h,
      child: ListView(
        children: [
          const SizedBox(height: 8),
          ListTile(
            title: const Text('Name'),
            trailing: Text(contact.fullname),
          ),
          ListTile(
            title: const Text('Address'),
            subtitle: const Text('Long press to copy to clipboard'),
            trailing: Text(
              addressFormat(contact.address),
            ),
            onLongPress: () {
              Clipboard.setData(ClipboardData(text: contact.address));
              showInfoSnackBar(message: 'Copied full address to clipboard');
            },
          ),
          ListTile(
            title: const Text('Balance'),
            subtitle: const Text('Long press to copy the full balance'),
            trailing: Obx(
              () => Text(
                edgFormat(BigInt.parse(contact.currentBalance.value)),
              ),
            ),
            onLongPress: () {
              Clipboard.setData(
                ClipboardData(text: contact.currentBalance.value),
              );
              showInfoSnackBar(message: 'Copied full balance to clipboard');
            },
          ),
        ],
      ),
    );
  }
}

class EmptyContactsSubView extends StatelessWidget {
  const EmptyContactsSubView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Such Empty, add some contacts',
        style: TextStyle(
          fontSize: 20.ssp,
          color: AppColors.disabled,
        ),
      ),
    );
  }
}

class _AddNewContactSheet extends StatelessWidget {
  const _AddNewContactSheet({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String fullname, address;
    return Container(
      color: Colors.white,
      height: 250.h,
      child: Column(
        children: [
          SizedBox(height: 16.h),
          Input(
            hintText: 'Fullname',
            onChanged: (v) {
              fullname = v;
            },
          ),
          SizedBox(height: 8.h),
          Input(
            hintText: 'Address',
            onChanged: (v) {
              address = v;
            },
          ),
          SizedBox(height: 16.h),
          Button(
            text: 'Save',
            onPressed: () {
              Get.back(
                result: Contact(fullname: fullname, address: address),
                closeOverlays: false,
              );
            },
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
