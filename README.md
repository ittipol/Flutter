# Flutter
- Install Flutter SDK and other setup (https://docs.flutter.dev/get-started/install/macos)
- Install Dart SDK (https://dart.dev/get-dart)
- Visual Studio Code (https://docs.flutter.dev/tools/vs-code)
- Kotlin version (https://kotlinlang.org/docs/releases.html#release-details)
- Using packages (https://docs.flutter.dev/packages-and-plugins/using-packages)

## Install Flutter SDK
``` bash
# Download Flutter SDK from Flutter Github repo
git clone https://github.com/flutter/flutter.git ~/Downloads/flutter
```

## Switching to a specific Flutter version
``` bash
# List Flutter channels
flutter channel

# Use stable version
git checkout stable

# Navigate to the Flutter SDK directory execute
git checkout <Flutter version>

# https://github.com/flutter/flutter/tags
git checkout 3.29.3

# Show information about the installed tooling
flutter doctor

flutter doctor -v
```

## Set Flutter environment path
1. Add Flutter binary to PATH environment variable
``` bash
# Open the .bash_profile file with a text editor
code ~/.bash_profile
```
2. Use the export command to add new environment variables
``` bash
# export [existing_variable_name]=[new_variable_value]:$[existing_variable_name]
export PATH="$PATH:~/Downloads/flutter"
```
3. Execute the new .bash_profile by either restarting the terminal window or using
``` bash
source ~/.bash-profile
```
4. Check a PATH environment variable
``` bash
echo $PATH
```
5. Verify the installation
``` bash
flutter --version
```

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

## Package
``` yaml
dependencies:
  package_a: ^4.2.0    # any version >= 4.2.0 but < 6.0.0
  package_b: '4.8.5'   # only version 4.8.5
  package_c: '>=2.6.1 <5.0.0' # any version >= 2.6.1 but < 5.0.0
```

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

### Open Xcode
``` bash
cd ios

xed .
```

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
flutter test test/data/remote/authentication_remote_test.dart -r expanded
```