import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../core/helper/helper_color.dart';

class MyCustomMarker extends CustomPainter {
  final String label;
  final int duration;

  MyCustomMarker({
    required this.label,
    required this.duration,
  });

  void _drawText({
    required Canvas canvas,
    required Size size,
    required String text,
    required double width,
    double? dx,
    double? dy,
    String? fontFamily,
    double fontSize = 22,
    Color color = Colors.black,
    FontWeight? fontWeight,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(
          text: text,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              color: color,
              fontFamily: fontFamily,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          )
      ),
      textDirection: TextDirection.ltr,
      maxLines: 2,
    );

    textPainter.layout(
      maxWidth: width,
    );

    textPainter.paint(
      canvas,
      Offset(
        dx ?? size.height * 0.5 - textPainter.width * 0.5,
        size.height * 0.5 - textPainter.size.height * 0.5 + (dy ?? 0),
      ),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.white;

    final rRect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      const Radius.circular(5),
    );

    canvas.drawRRect(rRect, paint);

    paint.color = HelperColor.primaryColor;

    final miniRect = RRect.fromLTRBAndCorners(
      0,
      0,
      size.height,
      size.height,
      topLeft: const Radius.circular(5),
      bottomLeft: const Radius.circular(5),
    );

    canvas.drawRRect(miniRect, paint);

    _drawText(
      canvas: canvas,
      size: size,
      text: label,
      dx: size.height + 10,
      width: size.width - size.height - 10,
    );

    if (duration == 0) {
      _drawText(
        canvas: canvas,
        size: size,
        text: String.fromCharCode(
          LineAwesomeIcons.map_marker.codePoint,
        ),
        fontFamily: LineAwesomeIcons.map_marker.fontFamily,
        fontSize: 40,
        color: Colors.white,
        width: size.height,
      );
    } else {
      final realDuration = Duration(seconds: duration);
      final minutes = realDuration.inMinutes;
      final String durationAsText = "${minutes > 59 ? realDuration.inHours : minutes}";
      _drawText(
        canvas: canvas,
        size: size,
        text: durationAsText,
        fontSize: 27,
        dy: -13,
        color: Colors.white,
        width: size.height,
        fontWeight: FontWeight.w300,
      );

      _drawText(
        canvas: canvas,
        size: size,
        text: minutes > 59 ? "HOURS" : "MIN",
        fontSize: 22,
        dy: 12,
        color: Colors.white,
        width: size.height,
        fontWeight: FontWeight.bold,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
