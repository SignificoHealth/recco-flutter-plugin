import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:recco/recco.dart';

import 'recco_method_channel.dart';

abstract class ReccoPlatform extends PlatformInterface {
  ReccoPlatform() : super(token: _token);

  static final Object _token = Object();

  static ReccoPlatform _instance = MethodChannelRecco();

  static ReccoPlatform get instance => _instance;

  static set instance(ReccoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> initialize(String clientSecret, ReccoStyle style) async {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  Future<void> login(String userId) {
    throw UnimplementedError('login() has not been implemented.');
  }

  Future<void> logout() {
    throw UnimplementedError('logout() has not been implemented.');
  }

  Future<void> openReccoUI() {
    throw UnimplementedError('openReccoUI() has not been implemented.');
  }
}
