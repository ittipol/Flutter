#Flutter


- Install Flutter SDK and other setup (https://docs.flutter.dev/get-started/install/macos)
- Install Dart SDK (https://dart.dev/get-dart)


## Command line
``` bash
flutter pub get


# Run application on a connected device, or iOS simulator, or Android Emulator
flutter run --flavor uat --dart-define=APP_ENV=uat --dart-define=CHECK_WIFI=false --dart-define=CHECK_USB_DEBUG=false


--flavor sit --dart-define=APP_ENV=sit --dart-define=CHECK_WIFI=false --dart-define=CHECK_USB_DEBUG=false


--flavor dev --dart-define=APP_ENV=dev --dart-define=CHECK_WIFI=false --dart-define=CHECK_USB_DEBUG=false


# Compiles to release mode
flutter run --release
```


### Difference between `flutter run` and `flutter build` command?
You need to use `flutter build` command with one of following parameters: apk, appbundle, ios. This will produce an application to deploy or publish on AppStore, PlayStore, or some other distribution channels like Firebase.


The `flutter run` command will run your application on a connected device, or iOS simulator, or Android Emulator. You can also use --verbose command to get a detailed log while running the application.


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

## Dart

### Document

- https://dart.dev/effective-dart/usage
