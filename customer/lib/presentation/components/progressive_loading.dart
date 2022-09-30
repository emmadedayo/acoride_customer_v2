import 'dart:ui';

import 'package:flutter/material.dart';

///
/// Wrap around any widget that makes an async call to show a modal progress
/// indicator while the async call is in progress.
///
/// The progress indicator can be turned on or off using [inAsyncCall]
///
/// The progress indicator defaults to a [CircularProgressIndicator] but can be
/// any kind of widget
///
/// The progress indicator can be positioned using [offset] otherwise it is
/// centered
///
/// The modal barrier can be dismissed using [dismissible]
///
/// The blurry effect's intensity can be be controlled using [blurEffectIntensity]
///
/// The color of the modal barrier can be set using [color]
///
/// The opacity of the modal barrier can be set using [opacity]
///
/// This is a rewritten version of the modal_progress_hud package with the blurry effect
///
class ProgressiveLoading extends StatelessWidget {
  final bool? inAsyncCall;
  final Color color;
  final double? height;
  const ProgressiveLoading({
    Key? key,
    required this.inAsyncCall,
    this.color = Colors.grey,
    this.height = 1,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return inAsyncCall!?
    LinearProgressIndicator(
      minHeight: height,
      backgroundColor: Colors.transparent,
      valueColor: AlwaysStoppedAnimation<Color>(color),
    ):Container();
  }
}
