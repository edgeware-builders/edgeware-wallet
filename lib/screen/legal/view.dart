import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Legal & Polices'),
        elevation: 0,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('About'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Edgeware Wallet',
                applicationIcon: Image.asset('assets/png/icon.png'),
                applicationVersion: '1.0-beta',
                applicationLegalese: '© Commonwealth Labs',
              );
            },
          ),
          ListTile(
            title: const Text('Website'),
            onTap: () async {
              const url = 'https://edgewa.re/';
              final canOpen = await canLaunch(url);
              if (canOpen) {
                await launch(
                  url,
                  forceWebView: true,
                  forceSafariVC: true,
                );
              }
            },
          ),
          ListTile(
            title: const Text('Whitepaper'),
            onTap: () async {
              const url =
                  'https://arena-attachments.s3.amazonaws.com/4643268/c8d128724f36b716660e4bf21823e760.pdf?1563310093';
              final canOpen = await canLaunch(url);
              if (canOpen) {
                await launch(url);
              }
            },
          ),
          ListTile(
            title: const Text('Code'),
            onTap: () async {
              const url = 'https://github.com/shekohex/edgeware-wallet';
              final canOpen = await canLaunch(url);
              if (canOpen) {
                await launch(
                  url,
                  forceWebView: true,
                  forceSafariVC: true,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
