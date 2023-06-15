import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class ShadowflightApi {
  void login(String userId);
  void logout();
  void navigateToDashboard();
}
