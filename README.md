# Flutter
- Install Flutter SDK and other setup (https://docs.flutter.dev/get-started/install/macos)
- Install Dart SDK (https://dart.dev/get-dart)
- Visual Studio Code (https://docs.flutter.dev/tools/vs-code)


## Command line
``` bash
# Get the current package's dependencies
flutter pub get

# The `flutter run` command will run your application on a connected device, or iOS simulator, or Android Emulator. You can also use --verbose command to get a detailed log while running the application.
flutter run

# If you need to pass multiple key-value pairs, just define --dart-define multiple times:
flutter run --dart-define=SOME_VAR=SOME_VALUE --dart-define=OTHER_VAR=OTHER_VALUE

# Compiles to release mode
flutter run --release
```

## Difference between `flutter run` and `flutter build` command
You need to use `flutter build` command with one of following parameters: apk, appbundle, ios. This will produce an application to deploy or publish on AppStore, PlayStore, or some other distribution channels like Firebase.

## Document
- https://docs.flutter.dev/
- https://dart.dev/effective-dart/usage
- https://dart.dev/language/class-modifiers

## Material Design
- Components (https://m3.material.io/components)

## Xcode

### To add a new simulated device, with a different version of iOS

- Window > Devices and Simulators > Simulators
- Click the "+" (at the bottom-left)
- Enter a new "Simulator Name"
- Choose "Device Type"
- Choose "OS Version"...
- ...if necessary, "Download more simulator runtimes...", and choose - the versions of iOS that you want
- Click "Create"

The simulator acts like an iPhone (or iPad).
It's a very accurate simulation, but of course some features are not available (like the on-device cameras)

### To start the Simulator, run the following command:
``` bash
open -a Simulator
```

## Android Studio
- Install (https://developer.android.com/studio/install)

### Create and manage virtual devices
- https://developer.android.com/studio/run/managing-avds

## Unit Test

``` bash
# Generate mock classes
dart run build_runner build -d

# Run test
flutter test -r expanded

# Run test with specific path
flutter test test/data/remote/pokemon_remote_test.dart -r expanded
```