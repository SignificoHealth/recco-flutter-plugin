# Flutter Shadowflight

A demo Flutter project for testing the integration with the Shadowflight SDK.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Communication between platforms

This app is using [Pigeon](https://pub.dev/packages/pigeon) lib to make easy the communication between different platforms.

This works as follow:
- Edit `pigeons/shadowflight_api.dart` file to create the communication API layer between flutter and other native platforms.
- Run  `./generate_pigeon.sh` to generate the API for the different platform languages. You can edit this file to set options for the generated code.
- The new generated code will be saved in the output folders specified in this file, in the platform folders (e.g: `android`, `ios`,...).
- Connect the concrete implementation of the generated API in your native code using the `.setUp()` method (see `MainActivity` as reference).
- Call the api methods from flutter code to communicate with the native platforms (see `lib/main.dart` as reference, this is the entry point of the app).
