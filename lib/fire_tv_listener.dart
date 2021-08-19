library fire_tv_listener;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget that listens for Fire TV remote events and calls the
/// specified callbacks
///
/// This widget requires a [FocusNode] and a [Widget] child.
///
/// Most key press events are called immediately when the user presses a button.
///
/// The special [afterKey] function is called after every detected event whether
/// a press [RawKeyDownEvent] or release [RawKeyUpEvent]. It is called after the
/// other events have been handled. This is useful for triggering a widget rebuild,
/// or for passing keyboard event data back to the parent for further handling.
class FireTVRemoteListener extends StatelessWidget {
  /// Will be called whenever the user presses Up on the remote.
  final void Function()? onUp;

  /// Will be called whenever the user presses Down on the remote.
  final void Function()? onDown;

  /// Will be called whenever the user presses Left on the remote.
  final void Function()? onLeft;

  /// Will be called whenever the user presses Right on the remote.
  final void Function()? onRight;

  /// Will be called whenever the user presses the Center Button on the remote.
  final void Function()? onSelect;

  /// Will be called whenever the user presses Play/Pause on the remote.
  final void Function()? onPlayPause;

  /// Will be called whenever the user presses Rewind on the remote.
  final void Function()? onRew;

  /// Will be called whenever the user presses FastForward on the remote.
  final void Function()? onFF;

  /// Will be called whenever the user presses the Menu Button on the remote.
  final void Function()? onMenu;

  /// Will be called after every key event whether KeyDown or KeyUp.
  final void Function(RawKeyEvent)? afterKey;
  final Widget child;
  final FocusNode focusNode;

  const FireTVRemoteListener({
    Key? key,
    this.onUp,
    this.onDown,
    this.onLeft,
    this.onRight,
    this.onSelect,
    this.onPlayPause,
    this.onRew,
    this.onFF,
    this.onMenu,
    this.afterKey,
    required this.child,
    required this.focusNode,
  }) : super(key: key);

  void handleEvent(RawKeyEvent event) {
    print(event);
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        onUp?.call();
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        onDown?.call();
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        onLeft?.call();
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        onRight?.call();
      } else if (event.logicalKey == LogicalKeyboardKey.select) {
        onSelect?.call();
      } else if (event.logicalKey == LogicalKeyboardKey.mediaPlayPause) {
        onPlayPause?.call();
      } else if (event.logicalKey == LogicalKeyboardKey.mediaFastForward) {
        onFF?.call();
      } else if (event.logicalKey == LogicalKeyboardKey.mediaRewind) {
        onRew?.call();
      } else if (event.logicalKey == LogicalKeyboardKey.contextMenu) {
        onMenu?.call();
      } else if (event.logicalKey == LogicalKeyboardKey.mediaPlayPause) {
        onPlayPause?.call();
      }
    }
    afterKey?.call(event);
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: focusNode,
      autofocus: true,
      onKey: handleEvent,
      child: child,
    );
  }
}
