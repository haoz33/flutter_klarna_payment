# Flutter Klarna Payment Plugin

The Flutter Klarna Payment is a Flutter plugin that enables you to integrate Klarna Payments into your Flutter application. This plugin provides a simple and easy-to-use interface for integrating Klarna Payments into the Flutter app.

## Installation

To use this plugin, follow these steps:

1. Add the following dependency to your `pubspec.yaml` file:

   ```yaml
   dependencies:
     flutter_klarna_payment: ^0.1.1
   ```

2. Run `flutter pub get` to install the dependency.


## Android Setup 

1. Add the Klarna Mobile SDK repository in the `android/build.gradle` build.gradle file.

```
allprojects {
    repositories {
        google()
        mavenCentral()
        maven {
            url 'https://x.klarnacdn.net/mobile-sdk/'
        }
    }
}
```

2. Add return url 

replace `https` and `com.example.flutter_klarna_payment` 

```xml
<application...>
    <activity...>
        <intent-filter>
            <action android:name="android.intent.action.VIEW" />
            <category android:name="android.intent.category.DEFAULT" />
            <category android:name="android.intent.category.BROWSABLE" />
        
            <data android:scheme="https" />
            <data android:host="com.example.flutter_klarna_payment" />
        </intent-filter>
    </activity>
</application>
```

## iOS setup

1. Add return url

see https://docs.klarna.com/mobile-sdk/ios/get-started/#configure-your-app-return-url for more detail

## Usage

Here's a basic example of how to use the Flutter Klarna Payment Plugin in your Flutter app:

```dart
import 'package:flutter/material.dart';

import 'package:flutter_klarna_payment/flutter_klarna_payment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = KlarnaPaymentController();
  String text = '';
  @override
  void initState() {
    super.initState();
    controller.stateStream.listen((event) {
      setState(() {
        text = event.state.name;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Column(
            children: [
              Expanded(
                child: KlarnaPaymentView(
                  controller: controller,
                  request: KlarnaPaymentRequest(
                    clientToken: token,
                    returnUrl: 'https://com.example.flutter_klarna_payment',
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.pay();
                  },
                  child: Text('Pay ${text}'))
            ],
          )),
    );
  }
}

const token =
    'XXX';

```

In this example, replace `'token'`, and `'returnUrl'` with your Klarna client token and return url. 

## Example

See completed example within the `example` folder

## License

This plugin is released under the MIT License. See the [LICENSE](LICENSE) file for details.