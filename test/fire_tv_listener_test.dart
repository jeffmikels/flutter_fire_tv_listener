import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fire_tv_listener/fire_tv_listener.dart';

void main() {
  testWidgets('checks the up event', (tester) async {
    var fn = FocusNode();
    RawKeyEvent? afterButtonEvent;
    RawKeyEvent? keyDownEvent;
    RawKeyEvent? keyUpEvent;

    var keysToTest = [
      LogicalKeyboardKey.arrowUp,
      LogicalKeyboardKey.arrowDown,
      LogicalKeyboardKey.arrowLeft,
      LogicalKeyboardKey.arrowRight,
      LogicalKeyboardKey.contextMenu,
      LogicalKeyboardKey.select,
      LogicalKeyboardKey.mediaFastForward,
      LogicalKeyboardKey.mediaRewind,
      LogicalKeyboardKey.mediaPlayPause,
    ];
    var keyPairs = <String, bool>{};
    for (var k in keysToTest) keyPairs[k.toStringShort()] = false;

    await tester.pumpWidget(FireTVRemoteListener(
      onUp: () => keyPairs[LogicalKeyboardKey.arrowUp.toStringShort()] = true,
      onDown: () => keyPairs[LogicalKeyboardKey.arrowDown.toStringShort()] = true,
      onLeft: () => keyPairs[LogicalKeyboardKey.arrowLeft.toStringShort()] = true,
      onRight: () => keyPairs[LogicalKeyboardKey.arrowRight.toStringShort()] = true,
      onMenu: () => keyPairs[LogicalKeyboardKey.contextMenu.toStringShort()] = true,
      onSelect: () => keyPairs[LogicalKeyboardKey.select.toStringShort()] = true,
      onFF: () => keyPairs[LogicalKeyboardKey.mediaFastForward.toStringShort()] = true,
      onRew: () => keyPairs[LogicalKeyboardKey.mediaRewind.toStringShort()] = true,
      onPlayPause: () => keyPairs[LogicalKeyboardKey.mediaPlayPause.toStringShort()] = true,
      onPressed: (event) => keyDownEvent = event,
      onReleased: (event) => keyUpEvent = event,
      afterButton: (event) => afterButtonEvent = event,
      focusNode: fn,
      child: Container(),
    ));

    for (var k in keysToTest) {
      await tester.sendKeyDownEvent(k);
      expect(keyPairs[k.toStringShort()], true);
      expect(afterButtonEvent!.logicalKey.toStringShort(), k.toStringShort());
      expect(keyDownEvent!.logicalKey.toStringShort(), k.toStringShort());
      await tester.sendKeyUpEvent(k);
      expect(keyUpEvent!.logicalKey.toStringShort(), k.toStringShort());
    }
  });
}
