import 'package:wallet/wallet.dart';

class TransferController extends GetxController
    with ContactsMixin, EdgewareAccountInfoMixin {
  TransferOperation op;
  @override
  void onInit() {
    super.onInit();
    op = Get.arguments;
  }

  @override
  Future<void> onReady() async {
    await super.onReady();
  }
}
