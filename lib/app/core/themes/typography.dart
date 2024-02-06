import 'package:flutter/material.dart';

class TypographyStyles {
  static const h1 =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w600, height: 1.2);
  static const h2 =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600, height: 1.2);
  static const h3 =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 1.2);
  static const h4 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600, height: 1.2);
  static const h5 =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1.2);

  static const b1 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      height: 1.5,
      letterSpacing: 1.5 / 100);
  static const b2 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 1.5,
      letterSpacing: 1.5 / 100);
  static const b3 = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.2,
      letterSpacing: 1.5 / 100);

    
}

extension WeightModifier on TextStyle {
  TextStyle semibold({Color color = Colors.black}) {
    return copyWith(fontWeight: FontWeight.w600, color: color);
  }

  TextStyle bold({Color color = Colors.black}) {
    return copyWith(fontWeight: FontWeight.w700, color: color);
  }

  TextStyle extraLarge({Color color = Colors.black}) {
    return copyWith(fontSize: 48, color: color);
  }

  TextStyle extraBold({Color color = Colors.black}) {
    return copyWith(fontWeight: FontWeight.w800, color: color);
  }
}
