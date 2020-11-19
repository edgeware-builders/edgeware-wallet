import 'package:get_storage/get_storage.dart';
import 'package:wallet/wallet.dart';

class Preferences extends GetxService {
  Preferences._() : _preferences = GetStorage('edgeware_preferences');

  static Future<Preferences> init() async {
    await GetStorage.init('edgeware_preferences');
    return Preferences._();
  }

  final GetStorage _preferences;

  ReadWriteValue<String> get fullname => ''.val(
        'fullname',
        getBox: () => _preferences,
      );

  ReadWriteValue<String> get address => ''.val(
        'address',
        getBox: () => _preferences,
      );
  ReadWriteValue<bool> get useBiometricAuth => true.val(
        'use_biometric_auth',
        getBox: () => _preferences,
      );
}
