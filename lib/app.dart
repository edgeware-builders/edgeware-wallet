import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet/wallet.dart';

class EdgewareWalletApp extends StatelessWidget {
  const EdgewareWalletApp({Key key, this.initialBinding}) : super(key: key);
  final Bindings initialBinding;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Edgeware Wallet',
      enableLog: !kReleaseMode,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.mainBackround,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: AppColors.mainBackround,
        splashColor: Colors.black26,
        scaffoldBackgroundColor: AppColors.mainBackround,
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      getPages: _buildPages(),
      initialBinding: initialBinding,
      initialRoute: Routes.splash,
      popGesture: true,
      defaultTransition: Transition.cupertino,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('en'),
      supportedLocales: const [
        Locale('en'),
      ],
    );
  }
}

List<GetPage> _buildPages() {
  return [
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: Routes.intro,
      page: () => IntroScreen(),
    ),
    GetPage(
      name: Routes.generateAccount,
      page: () => GenerateAccountScreen(),
      binding: GenerateAccountBindings(),
    ),
    GetPage(
      name: Routes.recoverAccount,
      page: () => RecoverAccountScreen(),
      binding: RecoverAccountBindings(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      binding: HomeBindings(),
    ),
  ];
}
