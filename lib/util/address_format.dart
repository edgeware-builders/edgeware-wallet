String addressFormat(String address) {
  if (address.length > 12) {
    final startPart = address.substring(0, 6);
    final endPart = address.substring(address.length - 6);
    return '$startPart...$endPart';
  } else {
    return address;
  }
}
