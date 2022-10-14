import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget{
  const ShimmerWidget({
    Key? key,
    required this.childWidget,
    this.baseColor,
    this.highlightColor,
  }): super (key: key);

  final Widget childWidget;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Shimmer.fromColors(
      baseColor: baseColor == null ? Colors.grey.shade200 : baseColor!,
      highlightColor: highlightColor == null ? Colors.white.withAlpha(50) : highlightColor!,
      child: childWidget,
    );
  }
}