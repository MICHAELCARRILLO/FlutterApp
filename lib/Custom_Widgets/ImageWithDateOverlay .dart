import 'dart:io' as io;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path_helper;
import 'package:http/http.dart' as http;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageWithDateOverlay extends StatelessWidget {
  final io.File imageFile;
  final String date;

  const ImageWithDateOverlay(
      {Key? key, required this.imageFile, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
      future: loadImage(imageFile),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final image = snapshot.data;
          final width = image!.width.toDouble();
          final height = image.height.toDouble();
          return CustomPaint(
            size: Size(width, height),
            painter: _DateOverlayPainter(image, date),
          );
        } else {
          return Container();
        }
      },
    );
  }

  static Future<ui.Image> loadImage(io.File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    return decodeImageFromList(bytes);
  }
}

class _DateOverlayPainter extends CustomPainter {
  final ui.Image image;
  final String date;

  _DateOverlayPainter(this.image, this.date);

  @override
  void paint(Canvas canvas, Size size) {
    final imageWidth = image.width.toDouble();
    final imageHeight = image.height.toDouble();

    // Draw the original image onto the canvas
    canvas.drawImage(image, Offset.zero, Paint());

    // Draw the date string on top of the original image
    final textPainter = TextPainter(
      text: TextSpan(
        text: date,
        style: TextStyle(
          color: Colors.white,
          fontSize: 75,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final textWidth = textPainter.width;
    final textHeight = textPainter.height;

    final x = imageWidth / 2 - textWidth / 2;
    final y = imageHeight / 2 - textHeight / 2;

    textPainter.paint(canvas, Offset(0, y));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
