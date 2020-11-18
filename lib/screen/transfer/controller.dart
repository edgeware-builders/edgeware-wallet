import 'package:wallet/wallet.dart';

class TransferController extends GetxController {
  TransferOperation op;
  @override
  void onInit() {
    super.onInit();
    op = Get.arguments;
  }
}
