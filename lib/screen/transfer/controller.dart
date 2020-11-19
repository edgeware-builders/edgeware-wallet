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

  Future<bool> transfer(Contact contact) async {
    final authorized = await Get.to(
      AuthScreen(),
      fullscreenDialog: true,
      popGesture: true,
      transition: Transition.downToUp,
    );
    if (authorized != null && authorized) {
      try {
        // ignore: unawaited_futures
        Get.dialog(
          MyAlertDialog(
            title: 'Sending EDG',
            content: 'Sending ${contact.fullname} ${edgFormat(op.amount)}',
          ),
          barrierDismissible: false,
        );
        await edgeware.balanceTransfer(
          toSs58: contact.address,
          amount: op.amount,
        );
        Get.close(1);
        await queryInfo();
        return true;
      } catch (e) {
        Get.close(1);
        showErrorSnackBar(message: e.message ?? e.toString());
        return false;
      } finally {
        edgeware.cleanKeyPair();
      }
    } else {
      showErrorSnackBar(message: 'authorization failed!', title: 'Auth Error');
      await Future.delayed(2.seconds);
      return false;
    }
  }
}
