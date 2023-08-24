import 'dart:ui';

import 'recco_platform_interface.dart';

class Recco {

  /// Configures Recco given a [clientSecret] and a [style].
  ///
  /// UI can be customized setting a [style] from the currently available: `Fresh`, `Ocean`, `Spring`, `Tech`
  Future<void> initialize(String clientSecret, ReccoStyle style) async {
    await ReccoPlatform.instance.initialize(clientSecret, style);
  }

  /// Sets user identifiers, and triggers login operation. User session login is tracked.
  ///
  /// [userId] identifier that enables Recco experience to be unique and custom.
  Future<void> login(String userId) async {
    await ReccoPlatform.instance.login(userId);
  }

  /// Clears user credentials, cached data and triggers logout operation.
  Future<void> logout() async {
    await ReccoPlatform.instance.logout();
  }

  /// Starts Recco experience by launching Recco on top of the current navigation stack.
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

  static ReccoStyle ocean() {
    return ReccoStyle(
        "Ocean",
        ReccoStyleColors(
            const Color(0xFFCEEEFF),
            const Color(0xFF263743),
            const Color(0xFF263743),
            const Color(0xFFe4f6ff),
            const Color(0xFF35b9ff),
            const Color(0xFFe4f6ff),
            const Color(0xFF35b9ff),
            const Color(0xFF88493f)),
        ReccoStyleColors(
            const Color(0xFF125e85),
            const Color(0xFFffffff),
            const Color(0xFFecf8fe),
            const Color(0xFF0c5175),
            const Color(0xFF35b9ff),
            const Color(0xFF17445b),
            const Color(0xFFf5a08c),
            const Color(0xFF105a81)));
  }

  static ReccoStyle spring() {
    return ReccoStyle(
        "Spring",
        ReccoStyleColors(
            const Color(0xFFffddbe),
            const Color(0xFF383b45),
            const Color(0xFF383b45),
            const Color(0xFFffffff),
            const Color(0xFF3ba17a),
            const Color(0xFFffe5ae),
            const Color(0xFFffc188),
            const Color(0xFF926500)),
        ReccoStyleColors(
            const Color(0xFF2c956d),
            const Color(0xFFffffff),
            const Color(0xFFfcfcfc),
            const Color(0xFF383b45),
            const Color(0xFFea8822),
            const Color(0xFF2c2783),
            const Color(0xFFffc188),
            const Color(0xFF306d49)));
  }

  static ReccoStyle tech() {
    return ReccoStyle(
        "Tech",
        ReccoStyleColors(
            const Color(0xFFe5e4a3),
            const Color(0xFF373733),
            const Color(0xFF242422),
            const Color(0xFFe5e4a3),
            const Color(0xFFe6e452),
            const Color(0xFFffffff),
            const Color(0xFFf5b731),
            const Color(0xFF403f15)),
        ReccoStyleColors(
            const Color(0xFF25291d),
            const Color(0xFFffffff),
            const Color(0xFFf8f9f4),
            const Color(0xFF383b45),
            const Color(0xFFbab714),
            const Color(0xFF6a6d65),
            const Color(0xFFf5b731),
            const Color(0xFF403f15)));
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
