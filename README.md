![recco_header](./art/recco_logo_amethyst.svg)


![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)

![Pub DEV](https://img.shields.io/badge/PubDev-1.3.0-blue)

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
  recco: 1.3.0
```

## Setup on Android

Ensure to have these keys in your `example/android/local.properties` file

```
sdk.dir=path_to_your_android_sdk
flutter.sdk=path_to_your_flutter_sdk
flutter.compileSdkVersion=34
```

### Github Packages

This Flutter plugin internally depends on the Recco Android SDK, which exposes its components through Github Packages. Therefore, the configuration for [Github Packages][Github-Packages] is required. Please refer to the [Personal Access Token][PAT] section to obtain a valid set of credentials. Once you have a valid Github PAT, proceed to configure your `gradle.properties` file located under the ~/.gradle/ folder.

```groovy
gprUser=your-github-user-here
gprKey=your-github-PAT-here
```

After setting the Github credentials, then you have to add to your app `build.gradle` file the next configuration to be able to fetch the packages:

```groovy
repositories {
    mavenLocal()
    maven { url 'https://jitpack.io' }
    maven {
        name = "GithubPackages"
        url = "https://maven.pkg.github.com/SignificoHealth/recco-android-sdk"
        credentials {
            username = gprUser
            password = gprKey
        }
    }
}
```

### Check Android Gradle plugin version and source compatibility

Ensure that in your root/top level `build.gradle` file the Android Gradle plugin version is at least `7.4.0`

Ensure that in your root/top level `build.gradle` file the Kotlin version is at least `1.9.0`

```groovy
buildscript {
    ext.kotlin_version = '1.9.0'
    ...
}    
```


Make sure also that in your app `build.gradle` is provided the following source compatibility configuration:

```groovy
android {
    //...
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_17
        targetCompatibility JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }
}
```

### Hilt dependency

Recco Android SDK depends internally on Hilt. If your Android app does not use Hilt already, you will have to add this setup:

In your root/top level `build.gradle` file, add the Hilt plugin:

```gradle
plugins {
    // ...
    id 'com.google.dagger.hilt.android' version "2.47" apply false
    id 'org.jetbrains.kotlin.android' version '1.8.0' apply false
}
```

Then, in your app `build.gradle` file, resolve the Kapt and Hilt plugins, and add Hilt dependencies:

```gradle
apply plugin: 'kotlin-kapt'
apply plugin: 'com.google.dagger.hilt.android'

dependencies {
    implementation "com.google.dagger:hilt-android:2.47"
    kapt "com.google.dagger:hilt-android-compiler:2.47"
}
```

As the last step, decorate your `Application` class with the `@HiltAndroidApp` annotation:

```kotlin
@HiltAndroidApp
class ShowcaseApp : FlutterApplication() {

}
```

and add it to the `AndroidManifest.xml`

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application
        android:name=".ShowcaseApp"
```

You can check the [Flutter example Android app][Flutter example Android app] for more details.

## Setup on iOS

This Flutter plugin internally depends on the Recco iOS SDK, which exposes its components through CocoaPods. **Important: Please make sure your Cocoapods master repo is up to date by running `pod repo update`**. After this, you need to add the Recco pod to your `Podfile` as follow:

```
pod 'ReccoUI'
```

_Note:_ Make sure you have defined `platform :ios, '14.0'` or higher in your `Podfile`.

## ReccoPlugin new Instance

```dart
final Recco _reccoPlugin = Recco();
```

## Init
Initialize Recco SDK at the `initState` of your app.

```dart
Future<void> _initializeRecco(String clientSecret) async {
    try {
      _reccoPlugin.initialize(clientSecret, ReccoStyle.spring(
         androidFont: AndroidFont.poppins,
         iosFont: IOSFont.sfPro
      ));
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
  }
```

As part of the initialize setup, you need to supply a `ReccoStyle` instance to configure some customization entry points:
* `IOSFont` & `AndroidFont`: These components expose the set of available predefined fonts for each platform.
* `ReccoStyleColors`: Defines the available colors to be customized as part of the palette. There already existing palettes to choose from, such as fresh or ocean.

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

[Flutter example Android app]:https://github.com/SignificoHealth/recco-flutter-plugin/tree/main/example/android
[Recco SDK Android]:https://github.com/SignificoHealth/recco-android-sdk
[Recco SDK iOS]:https://github.com/SignificoHealth/recco-ios-sdk
[Github-Packages]:https://github.com/features/packages
[PAT]:https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens
