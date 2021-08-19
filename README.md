# fire_tv_listener

This Widget listens to events from a Fire TV Remote control and triggers a callback function for each

## Installation

Add `fire_tv_listener` to your `pubspec.yaml`

```
flutter pub get fire_tv_listener
```

## Usage

Import it into your code:

```
import 'package:fire_tv_listener/fire_tv_listener.dart';
```

And wrap your application in a `FireTVRemoteListener` Widget.

Here is an example.

```dart
// EXAMPLE CODE
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(Example());
}

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final fn = FocusNode();

  String pressed = '- PRESS A BUTTON -';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    fn.dispose();
  }

  void rebuild() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FireTVRemoteListener(
      onUp: () => pressed = 'UP',
      onDown: () => pressed = 'DOWN',
      onLeft: () => pressed = 'LEFT',
      onRight: () => pressed = 'RIGHT',
      onMenu: () => pressed = 'MENU',
      onSelect: () => pressed = 'SELECT',
      onFF: () => pressed = 'FF',
      onRew: () => pressed = 'REW',
      onPlayPause: () => pressed = 'PLAY/PAUSE',
      // onBack: () => back = true, // back sends android back key
      afterKey: (event) {
        if (event is RawKeyUpEvent) pressed = '- PRESS A BUTTON -';
        rebuild();
      },
      focusNode: fn,
      child: Scaffold(
        body: Center(child: Text(pressed, style: TextStyle(fontSize: 60))),
      ),
    );
  }
}
```
