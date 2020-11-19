import 'package:wallet/wallet.dart';

class ContactsController extends GetxController with ContactsMixin {
  Future<void> queryContactBalance(Contact contact) async {
    final info = await edgware.queryAccountInfo(ss58: contact.address);
    print('$contact => $info');
    contact.currentBalance.value = info.free.toString();
  }

  Future<bool> deleteContact(Contact contact) async {
    if (contact == null) {
      return false;
    }
    await contact.delete(db);
    contacts.removeWhere((e) => e.contactId == contact.contactId);
    loadedContacts.removeWhere((e) => e.contactId == contact.contactId);
    return true;
  }
}
