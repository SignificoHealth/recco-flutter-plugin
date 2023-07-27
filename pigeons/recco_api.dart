import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class ReccoApi {
  void login(String userId);
  void logout();
  void navigateToDashboard();
}
