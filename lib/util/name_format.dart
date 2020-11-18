String nameFormat(String name) {
  final parts = name.split(' ');
  if (parts.length > 1) {
    final firstLetter = parts.first[0];
    final lastLetter = parts.last[0];
    return '$firstLetter$lastLetter'.toUpperCase();
  } else if (name.length >= 2) {
    final firstLetter = name[0];
    final secondLetter = name[1];
    return '$firstLetter$secondLetter'.toUpperCase();
  } else {
    return '?';
  }
}
