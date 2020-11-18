import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/wallet.dart';

class MyInformationScreen extends GetView<MyInformationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Information'),
        elevation: 0,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Name'),
            subtitle: const Text('Add your full name'),
            trailing: Obx(() => Text(controller.fullname.value)),
            onTap: () {
              Get.to(_FullnameView());
            },
          ),
          ListTile(
            title: const Text('Address'),
            subtitle: const Text('Long press to copy to clipboard'),
            trailing: Text(
              addressFormat(controller.address),
            ),
            onLongPress: () {
              Clipboard.setData(ClipboardData(text: controller.address));
              showInfoSnackBar(message: 'Copied full address to clipboard');
            },
          ),
          ListTile(
            title: const Text('Balance'),
            subtitle: const Text('Long press to copy view the full balance'),
            trailing: Obx(
              () => Text(
                edgFormat(BigInt.parse(controller.currentBalance.value)),
              ),
            ),
            onLongPress: () {
              Clipboard.setData(
                ClipboardData(text: controller.currentBalance.value),
              );
              showInfoSnackBar(message: 'Copied full balance to clipboard');
            },
          ),
        ],
      ),
    );
  }
}

class _FullnameView extends GetView<MyInformationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Name'),
        elevation: 0,
        actions: [
          FlatButton(
            onPressed: () {
              controller.updateFullname();
            },
            disabledTextColor: Colors.white38,
            child: const Text('SAVE'),
          ),
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            maxLength: 255,
            controller: controller.fullnameController,
            enableSuggestions: true,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              hintText: 'Full name',
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              hintStyle: TextStyle(
                color: Colors.black38,
              ),
              counterStyle: TextStyle(
                color: Colors.black38,
              ),
            ),
          ).paddingAll(8),
          const Text(
            'Your name will be public for all of your contacts'
            ' and anyone you have matched with.',
            style: TextStyle(color: Colors.black26),
            textAlign: TextAlign.start,
          ).paddingAll(8),
        ],
      ),
    );
  }
}
