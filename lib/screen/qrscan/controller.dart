import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wallet/wallet.dart';

class QrScanController extends GetxController {
  QRViewController _qr;

  set qr(QRViewController qr) {
    _qr = qr;
    listenToStream();
  }

  QRViewController get qr => _qr;

  void listenToStream() {
    qr?.scannedDataStream?.listen((event) {
      final account = decodeAccountQr(event);
      if (account != null) {
        _qr?.dispose(); // close the qr scanner.
        Get.back(result: account);
      }
    });
  }

  @override
  void onClose() {
    _qr?.dispose();
    super.onClose();
  }
}
