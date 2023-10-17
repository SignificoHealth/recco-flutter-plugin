# RECCO PLUGIN: PUBLISHING A NEW RELEASE

## Create a pull request
Open a PR with the following changes:
- Bump each Recco SDK version (if required). For Android, increase the dependency version in  `android/build.gradle`. For ios, the one defined in `ios/recco.podspec`.
- Update the Recco version in the top level [pubspec][pubspec] file to the new version, following Semantic Versioning (MAJOR.MINOR.PATCH).
- In the [README][README] file, update any references mentioning the current version.
- Add a new entry to the [CHANGELOG][CHANGELOG] file describing all the changes contained in this new release.

## Publish to pub.dev
Double check running `flutter pub publish --dry-run` that there are no warnings before actually publishing the new release by executing `flutter pub publish`.

[CHANGELOG]:../CHANGELOG.md
[README]:../README.md
[pubspec]:../pubspec.yaml