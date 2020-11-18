import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wallet/wallet.dart';

class QrScanScreen extends StatelessWidget {
  const QrScanScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QrScanController());
    return Scaffold(
      body: QRView(
        key: GlobalKey(debugLabel: 'QR'),
        onQRViewCreated: (qr) {
          controller.qr = qr;
        },
        overlay: QrScannerOverlayShape(
          borderColor: AppColors.primary,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 300,
        ),
      ),
    );
  }
}
