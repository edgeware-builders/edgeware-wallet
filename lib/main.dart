import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wallet/wallet.dart';
import 'package:wallet/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init global dependencies
  await AppBindings().dependencies();
  runApp(EdgewareWalletApp(initialBinding: AppBindings()));
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.mainBackround,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.mainBackround,
      systemNavigationBarDividerColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
}
