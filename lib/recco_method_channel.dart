import 'package:flutter/services.dart';
import 'package:recco/recco.dart';

import 'recco_platform_interface.dart';

class MethodChannelRecco extends ReccoPlatform {
  final methodChannel = const MethodChannel('recco');

  @override
  Future<void> initialize(String clientSecret, ReccoStyle style) async {
    await methodChannel.invokeMethod<String>('initialize', {
      "clientSecret": clientSecret,
      "style": {
        "name": style.name,
        "colors": {
          "dark": {
            "primary": style.dark.primary.toHex(),
            "onPrimary": style.dark.onPrimary.toHex(),
            "background": style.dark.background.toHex(),
            "onBackground": style.dark.onBackground.toHex(),
            "accent": style.dark.accent.toHex(),
            "onAccent": style.dark.onAccent.toHex(),
            "illustration": style.dark.illustration.toHex(),
            "illustrationOutline": style.dark.illustrationOutline.toHex()
          },
          "light": {
            "primary": style.light.primary.toHex(),
            "onPrimary": style.light.onPrimary.toHex(),
            "background": style.light.background.toHex(),
            "onBackground": style.light.onBackground.toHex(),
            "accent": style.light.accent.toHex(),
            "onAccent": style.light.onAccent.toHex(),
            "illustration": style.light.illustration.toHex(),
            "illustrationOutline": style.light.illustrationOutline.toHex()
          }
        }
      }
    });
  }

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

extension on Color {
  String toHex() => '#${value.toRadixString(16)}';
}