import 'recco_platform_interface.dart';

class Recco {
  Future<void> login(String userId) async {
    await ReccoPlatform.instance.login(userId);
  }

  Future<void> logout() async {
    await ReccoPlatform.instance.logout();
  }

  Future<void> openReccoUI() async {
    await ReccoPlatform.instance.openReccoUI();
  }
}
