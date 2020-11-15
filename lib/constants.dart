import 'dart:ui';

class AppColors {
  static const Color mainBackround = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF0A95DF);
  static const Color lightBackround = Color(0xFFF2F2F2);
  static const Color disabled = Color(0xFF757575);
  static const Color danger = Color(0xFFCC3040);
}

const Size kDesignSize = Size(375, 812);

class Routes {
  static const String splash = '/';
  static const String intro = '/intro';
  static const String blank = '/blank';
  static const String generateAccount = '/generate-account';
  static const String recoverAccount = '/recover-account';
  static const String home = '/home';
  static const String me = '/me';
  static const String myInformation = '/me/info';
  static const String myContacts = '/me/contacts';
  static const String settings = '/me/settings';
  static const String legal = '/me/legal';
  static const String walletTransfer = '/wallet-transfer';
}

const String mainNetRpcEndpoint = 'wss://mainnet1.edgewa.re/';
const String testNetRpcEndpoint = 'wss://beresheet1.edgewa.re/';

class TableNames {
  static const String contacts = 'contacts';
}
