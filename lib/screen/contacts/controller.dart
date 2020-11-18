import 'package:wallet/wallet.dart';

class ContactsController extends GetxController with ContactsMixin {
  Future<void> queryContactBalance(Contact contact) async {
    final info = await edgware.queryAccountInfo(ss58: contact.address);
    print('$contact => $info');
    contact.currentBalance.value = info.free.toString();
  }
}
