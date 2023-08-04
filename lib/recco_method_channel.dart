import 'package:flutter/services.dart';

import 'recco_platform_interface.dart';

class MethodChannelRecco extends ReccoPlatform {
  final methodChannel = const MethodChannel('recco');

  @override
  Future<void> login(String userId) async {
    await methodChannel.invokeMethod<String>('login', {"userId":userId});
  }

  @override
  Future<void> logout() async {
    await methodChannel.invokeMethod<String>('logout');
  }

  @override
  Future<void> openReccoUI() async {
    await methodChannel.invokeMethod<String>('openReccoUI');
  }
}
