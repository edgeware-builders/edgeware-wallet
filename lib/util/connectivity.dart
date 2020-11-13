import 'package:connectivity/connectivity.dart';

Future<bool> isConnectedToNetwork() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
}
