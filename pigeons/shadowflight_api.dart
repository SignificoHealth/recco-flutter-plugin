import 'package:pigeon/pigeon.dart';

class Message {
  String? title;
  String? text;
}

@HostApi()
abstract class ShadowflightApi {
  Message replyBackTest(String text);
  void openShadowflightSDK(String userId);
}
