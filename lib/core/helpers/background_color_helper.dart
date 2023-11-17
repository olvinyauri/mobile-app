import 'package:flutter/material.dart';

class BackgroundColorHelper {
  static Color stringToPastelColor(String text,
      {int? saturation, int? lightness}) {
    final int hash = text.hashCode;
    final int hue = hash % 360;
    final HSLColor hslColor = HSLColor.fromAHSL(1.0, hue.toDouble(),
        saturation?.toDouble() ?? 0.5, lightness?.toDouble() ?? 0.5);
    return hslColor.toColor();
  }
}
