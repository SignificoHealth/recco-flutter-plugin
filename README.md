![recco_header](./art/recco_logo_amethyst.svg)


![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)

![Pub DEV](https://img.shields.io/badge/PubDev-0.0.2-blue)

# Recco Flutter Plugin

This repository holds the codebase for the Recco Flutter plugin. Instructions on how to add and use this plugin can be found in the [Usage](#usage) section.


# Overview

Personalized, and user-friendly approach to health and wellness recommendations based on users' unique interests, motivations, and health behaviors. Whether they are looking to improve their fitness, manage their stress, or simply lead a more fulfilling life. __`Recco` is designed to help them reach their full potential.__

Learn more about Recco SDK:

- [Recco SDK Android][Recco SDK Android]
- [Recco SDK iOS][Recco SDK iOS]

## Usage

Add this to pubspec.yaml

```yml
dependencies:
  recco: 0.0.2
```

## Initial setup on Android
This Flutter plugin internally depends on the Recco Android SDK, which exposes its components through Github Packages. Therefore, the configuration for [Github Packages][Github-Packages] is required. Please refer to the [Personal Access Token][PAT] section to obtain a valid set of credentials. Once you have a valid Github PAT, proceed to configure your `gradle.properties` file located under the ~/.gradle/ folder.

```groovy
gprUser=your-github-user-here
gprKey=your-github-PAT-here
```

Recco Android SDK depends internally on Hilt. If your Android app does not use Hilt already, you will have to add this setup:

Add Hilt dependency to your app `build.gradle`:

```gradle
implementation "com.google.dagger:hilt-android:2.47"
kapt "com.google.dagger:hilt-android-compiler:2.47"
```

Then decorate your `Application` class with the `@HiltAndroidApp` annotation:

```kotlin
@HiltAndroidApp
class ShowcaseApp : FlutterApplication() {

}
```
You can check the `example` app inside this repo for more details.

## ReccoPlugin new Instance

```dart
final Recco _reccoPlugin = Recco();
```

## Init
Initialize Recco SDK at the `initState` of your app.

```dart
Future<void> _initializeRecco(String clientSecret) async {
    try {
      _reccoPlugin.initialize(clientSecret, ReccoStyle.spring());
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
  }
```

## Login

```dart
Future<String> _loginReccoSDK(String userId) async {
    try {
        _reccoPlugin.login(userId);
    } on PlatformException catch (e) {
        debugPrint("Error: '${e.message}'.");
    }
    return userId;
}
```

## Logout

```dart
Future<void> _logoutReccoSDK() async {
    try {
      _reccoPlugin.logout();
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
}
```

## OpenReccoUi

```dart
Future<void> _openReccoUI() async {
    try {
      _reccoPlugin.openReccoUI();
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
}
```

[Recco SDK Android]:https://github.com/sf-recco/android-sdk
[Recco SDK iOS]:https://github.com/sf-recco/ios-sdk
[Github-Packages]:https://github.com/features/packages
[PAT]:https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens