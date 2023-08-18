import 'dart:ui';

import 'recco_platform_interface.dart';

class Recco {
  Future<void> initialize(String clientSecret, ReccoStyle style) async {
    await ReccoPlatform.instance.initialize(clientSecret, style);
  }

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

class ReccoStyle {
  final String name;
  final ReccoStyleColors dark;
  final ReccoStyleColors light;

  ReccoStyle(this.name, this.dark, this.light);

  static ReccoStyle fresh() {
    return ReccoStyle(
        "Fresh",
        ReccoStyleColors(
            const Color(0xFFffe6b0),
            const Color(0xFF383b45),
            const Color(0xFF383b45),
            const Color(0xFFffffff),
            const Color(0xFF7b61ff),
            const Color(0xFFffe5ae),
            const Color(0xFFf5b731),
            const Color(0xFF7b61ff)),
        ReccoStyleColors(
            const Color(0xFF383b45),
            const Color(0xFFFFFFFF),
            const Color(0xFFfcfcfc),
            const Color(0xFF383b45),
            const Color(0xFF7b61ff),
            const Color(0xFF2c2783),
            const Color(0xFFf5b731),
            const Color(0xFF454138)));
  }
}

class ReccoStyleColors {
  final Color primary;
  final Color onPrimary;
  final Color background;
  final Color onBackground;
  final Color accent;
  final Color onAccent;
  final Color illustration;
  final Color illustrationOutline;

  ReccoStyleColors(
      this.primary,
      this.onPrimary,
      this.background,
      this.onBackground,
      this.accent,
      this.onAccent,
      this.illustration,
      this.illustrationOutline);
}

