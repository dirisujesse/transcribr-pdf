import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../font_loader.dart';
import '../../utils.dart';

class PdfTextStyles {
  Font? font;
  Font? fontBold;
  Font? fontSemiBold;
  List<Font> fallbacks;

  PdfTextStyles._({
    required this.font,
    required this.fontBold,
    required this.fontSemiBold,
    this.fallbacks = const [],
  });

  static Future<PdfTextStyles> init() async {
    final fonts = await Future.wait([
      FontLoader.figtreeRegular,
      FontLoader.figtreeBold,
      FontLoader.figtreeSemiBold,
      FontLoader.lateef,
      FontLoader.ezra,
    ]);

    return PdfTextStyles._(
      font: Font.ttf(fonts[0] ?? ByteData(0)),
      fontBold: Font.ttf(fonts[1] ?? ByteData(0)),
      fontSemiBold: Font.ttf(fonts[2] ?? ByteData(0)),
      fallbacks: [
        Font.ttf(fonts[3] ?? ByteData(0)),
        Font.ttf(fonts[4] ?? ByteData(0)),
      ],
    );
  }

  TextStyle t1({TextDecoration? decoration, PdfColor? color}) {
    return TextStyle(
      font: fontBold,
      fontFallback: fallbacks,
      fontWeight: FontWeight.bold,
      fontSize: 24,
      decoration: decoration,
      letterSpacing: -0.4,
      color: color ?? AppPdfColors.textColor,
    );
  }

  TextStyle t2({TextDecoration? decoration, PdfColor? color}) {
    return TextStyle(
      font: fontBold,
      fontFallback: fallbacks,
      fontWeight: FontWeight.bold,
      fontSize: 18,
      decoration: decoration,
      letterSpacing: -0.4,
      color: color ?? AppPdfColors.textColor,
    );
  }

  TextStyle t3({TextDecoration? decoration, PdfColor? color}) {
    return TextStyle(
      font: fontSemiBold,
      fontFallback: fallbacks,
      fontWeight: FontWeight.normal,
      fontSize: 16,
      decoration: decoration,
      letterSpacing: -0.4,
      color: color ?? AppPdfColors.textColor,
    );
  }

  TextStyle body({TextDecoration? decoration, PdfColor? color}) {
    return TextStyle(
      font: font,
      fontFallback: fallbacks,
      fontWeight: FontWeight.normal,
      fontSize: 14,
      decoration: decoration,
      letterSpacing: -0.1,
      color: color ?? AppPdfColors.textColor,
    );
  }

  TextStyle button1({TextDecoration? decoration, PdfColor? color}) {
    return TextStyle(
      font: fontSemiBold,
      fontFallback: fallbacks,
      fontWeight: FontWeight.normal,
      fontSize: 14,
      decoration: decoration,
      letterSpacing: -0.1,
      color: color ?? AppPdfColors.textColor,
    );
  }

  TextStyle subHead1({TextDecoration? decoration, PdfColor? color}) {
    return TextStyle(
      font: fontSemiBold,
      fontFallback: fallbacks,
      fontWeight: FontWeight.normal,
      fontSize: 11,
      decoration: decoration,
      letterSpacing: 0,
      color: color ?? AppPdfColors.textColor,
    );
  }

  TextStyle bannerHeading({TextDecoration? decoration, PdfColor? color}) {
    return TextStyle(
      font: fontBold,
      fontFallback: fallbacks,
      fontWeight: FontWeight.bold,
      fontSize: 12,
      decoration: decoration,
      letterSpacing: -0.4,
      color: color ?? AppPdfColors.textColor,
    );
  }

  TextStyle callout({TextDecoration? decoration, PdfColor? color}) {
    return TextStyle(
      font: font,
      fontFallback: fallbacks,
      fontWeight: FontWeight.normal,
      fontSize: 11,
      decoration: decoration,
      letterSpacing: -0.2,
      color: color ?? AppPdfColors.textColor,
    );
  }

  TextStyle textPlaceholder({TextDecoration? decoration, PdfColor? color}) {
    return TextStyle(
      font: font,
      fontFallback: fallbacks,
      fontWeight: FontWeight.normal,
      fontSize: 10,
      decoration: decoration,
      height: 1.48,
      letterSpacing: -0.2,
      color: color ?? AppPdfColors.textColor,
    );
  }
}
