import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wallet/wallet.dart';

class SecureStorage extends GetxService {
  final _storage = const FlutterSecureStorage();

  Future<void> writeEntropy(String entropyBase64) async {
    await _storage.write(
      key: 'edgeware:keystore:entropy',
      value: entropyBase64,
    );
  }

  Future<String> readEntropy() async {
    final key = await _storage.read(key: 'edgeware:keystore:entropy');
    if (key == null) {
      throw StateError('Entropy not found');
    } else {
      return key;
    }
  }

  Future<void> deleteEntropy() async {
    await _storage.delete(
      key: 'edgeware:keystore:entropy',
    );
  }

  Future<void> writePassword(String password) async {
    await _storage.write(
      key: 'edgeware:keystore:password',
      value: password,
    );
  }

  Future<String> readPassword() async {
    final key = await _storage.read(key: 'edgeware:keystore:password');
    if (key == null) {
      throw StateError('password not found');
    } else {
      return key;
    }
  }

  Future<void> deletePassword() async {
    await _storage.delete(
      key: 'edgeware:keystore:password',
    );
  }

  Future<bool> hasEntropy() {
    return _storage.containsKey(key: 'edgeware:keystore:entropy');
  }

  Future<void> deleteAll() async {
    return _storage.deleteAll();
  }
}
