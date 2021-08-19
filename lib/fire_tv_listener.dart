library fire_tv_listener;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget that listens for Fire TV remote events and calls the
/// specified callbacks
///
/// This widget requires a [FocusNode] and a [Widget] child.
///
/// The special [afterKey] function is called after every detected event has
/// been handled. This is useful for triggering a widget rebuild, or for
/// passing keyboard event data back to the parent for further handling
class FireTVRemoteListener extends StatelessWidget {
  final void Function()? onUp;
  final void Function()? onDown;
  final void Function()? onLeft;
  final void Function()? onRight;
  final void Function()? onSelect;
  final void Function()? onPlayPause;
  final void Function()? onRew;
  final void Function()? onFF;
  final void Function()? onMenu;
  final void Function()? onBack;
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
    this.onBack,
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
