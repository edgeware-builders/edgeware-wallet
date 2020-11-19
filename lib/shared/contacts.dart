import 'package:edgeware/edgeware.dart';
import 'package:wallet/wallet.dart';

mixin ContactsMixin on GetxController {
  final db = Get.find<Database>();
  final edgware = Get.find<Edgeware>();

  final contacts = List<Contact>.empty(growable: true).obs;
  final loadedContacts = List<Contact>.empty(growable: true);

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
    await contactsStream.forEach(loadedContacts.add);
    contacts.addAll(loadedContacts);
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
      loadedContacts.add(contact);
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
    if (result == null) {
      return;
    }
    final contact = Contact(fullname: result.fullname, address: result.address);
    final saved = await saveContact(contact);
    if (saved) {
      showInfoSnackBar(message: 'Contact ${contact.fullname} Saved!');
    }
  }

  Future<void> filter(String keyword) async {
    final niddle = keyword.toLowerCase().trim();
    if (niddle.isEmpty) {
      contacts
        ..clear()
        ..addAll(loadedContacts);
    }
    final filtered = loadedContacts.where(
      (c) =>
          c.fullname.toLowerCase().contains(niddle) ||
          c.address.contains(niddle),
    );
    contacts
      ..clear()
      ..addAll(filtered);
  }
}
