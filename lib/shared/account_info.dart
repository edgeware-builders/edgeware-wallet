import 'package:edgeware/edgeware.dart';
import 'package:wallet/wallet.dart';

mixin EdgewareAccountInfoMixin on GetxController {
  final edgeware = Get.find<Edgeware>();
  final pref = Get.find<Preferences>();

  final fullname = ''.obs;
  final currentBalance = '0'.obs;

  String get address => pref.address.val;

  @override
  void onInit() {
    super.onInit();
    fullname.value = pref.fullname.val;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    final info = await queryInfo();
    print('my info $info');
    currentBalance.value = info.free.toString();
  }

  Future<AccountInfo> queryInfo({String ss58}) async {
    try {
      var address = pref.address.val;
      if (ss58 != null) {
        address = ss58;
      }
      return edgeware.queryAccountInfo(ss58: address);
    } catch (e) {
      showErrorSnackBar(message: e.message ?? e.toString());
      rethrow;
    }
  }
}
