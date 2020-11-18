class AccountQr {
  const AccountQr(this.fullname, this.address);
  final String fullname, address;
}

String encodeAccountQr(AccountQr data) {
  return 'EDG+${data.fullname}+${data.address}';
}

AccountQr decodeAccountQr(String data) {
  final parts = data.split('+');
  if (parts[0] != 'EDG') {
    return null;
  } else {
    final fullname = parts[1];
    final address = parts[2];
    return AccountQr(fullname, address);
  }
}
