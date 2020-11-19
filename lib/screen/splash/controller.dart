import 'package:edgeware/edgeware.dart';
import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

class SplashController extends GetxController {
  final _secureStorage = Get.find<SecureStorage>();
  final _edgeware = Get.find<Edgeware>();
  @override
  Future<void> onReady() async {
    super.onReady();
    final hasEntropy = await _secureStorage.hasEntropy();
    try {
      final isConnected = await isConnectedToNetwork();
      if (isConnected) {
        await _edgeware
            .initRpcClient(url: testNetRpcEndpoint)
            .timeout(10.seconds);
      } else {
        await Get.dialog(
          MyAlertDialog(
            title: 'No Internet Connection',
            content: 'It seems that you are not connected to the internet'
                'the application will face some issues',
            actions: [
              FlatButton(
                child: const Text('I KNOW'),
                onPressed: () {
                  Get.back();
                },
              )
            ],
          ),
        );
      }
    } catch (e) {
      showErrorSnackBar(message: e.message ?? e.toString());
    }
    if (hasEntropy) {
      // ignore: unawaited_futures
      Get.offAllNamed(Routes.home);
    } else {
      // ignore: unawaited_futures
      Get.offAllNamed(Routes.intro);
    }
  }
}
