import 'package:edgeware/edgeware.dart';
import 'package:wallet/wallet.dart';

mixin ContactsMixin on GetxController {
  final db = Get.find<Database>();
  final edgware = Get.find<Edgeware>();

  final contacts = List<Contact>.empty(growable: true).obs;

  @override
  Future<void> onReady() async {
    super.onReady();
    await loadContacts();
  }

  @override
  void onClose() {
    contacts.clear();
    super.onClose();
  }

  Future<void> loadContacts() async {
    final contactsStream = Contact.fetch(db, limit: 100);
    await contactsStream.forEach(contacts.add);
  }

  Future<bool> saveContact(Contact contact) async {
    if (contact == null) {
      return false;
    }
    // validate contact
    if (contact.fullname.isNullOrBlank) {
      showErrorSnackBar(
        message: 'Contact should get a name',
        title: 'Save Failed',
      );
      return false;
    }
    if (contact.address.isNullOrBlank) {
      showErrorSnackBar(
        message: 'Contact should get a unique address',
        title: 'Save Failed',
      );
      return false;
    }
    final isValidAddress = edgware.isValidEdgewareAddress(contact.address);
    if (isValidAddress) {
      await contact.save(db);
      contacts.add(contact);
    } else {
      showErrorSnackBar(
        message: 'Invalid Edgeware Contact Address!',
        title: 'Save Failed',
      );
      return false;
    }

    return true;
  }

  Future<void> scanContactQr() async {
    final result = await Get.to<AccountQr>(const QrScanScreen());
    final contact = Contact(fullname: result.fullname, address: result.address);
    final saved = await saveContact(contact);
    if (saved) {
      showInfoSnackBar(message: 'Contact ${contact.fullname} Saved!');
    }
  }
}
