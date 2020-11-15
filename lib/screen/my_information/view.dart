import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

class MyInformationScreen extends GetView<MyInformationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drew's Information"),
        elevation: 0,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Name'),
            subtitle: const Text('Add your full name'),
            trailing: const Text('Drew Stone'),
            onTap: () {
              Get.to(_FullnameView());
            },
          ),
          ListTile(
            title: const Text('Address'),
            subtitle: const Text('Long press to copy to clipboard'),
            trailing: Text(
              addressFormat('5FBsymTnut7qBaE4w93KrsAoZKpaC1vxUZ2TZqNtVKi9FmG5'),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Balance'),
            subtitle: const Text('Long press to copy view the full balance'),
            trailing: Text(
              edgFormat(BigInt.parse('99999')),
            ),
            onTap: () {},
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
            onPressed: () {},
            disabledTextColor: Colors.white38,
            child: const Text('SAVE'),
          ),
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            maxLength: 255,
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
