import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;

import 'logger.dart';

class FontLoader {
  static final Map<String, ByteData> _fontCache = {};

  static Future<ByteData> _load(String path) async {
    if (_fontCache.containsKey(path)) {
      return _fontCache[path]!;
    }

    final file = File(path);
    if (!file.existsSync()) {
      throw Exception('Font file not found: $path');
    }
    final bytes = await file.readAsBytes();
    final byteData = ByteData.view(bytes.buffer);
    _fontCache[path] = byteData;
    return byteData;
  }

  static String _getFontPath(String fontName) {
    return p.join(Directory.current.path, 'assets', 'fonts', '$fontName.ttf');
  }

  static Future<ByteData?> get ezra async {
    try {
      return await _load(_getFontPath('Ezra-Regular'));
    } catch (e, t) {
      AppLogger.severe(
        'Error loading Ezra-Regular font: $e',
        error: e,
        stackTrace: t,
      );
      return null;
    }
  }

  static Future<ByteData?> get lateef async {
    try {
      return await _load(_getFontPath('Lateef-Regular'));
    } catch (e, t) {
      AppLogger.severe(
        'Error loading Lateef-Regular font: $e',
        error: e,
        stackTrace: t,
      );
      return null;
    }
  }

  static Future<ByteData?> get figtreeRegular async {
    try {
      return await _load(_getFontPath('Figtree-Regular'));
    } catch (e, t) {
      AppLogger.severe(
        'Error loading Figtree-Regular font: $e',
        error: e,
        stackTrace: t,
      );
      return null;
    }
  }

  static Future<ByteData?> get figtreeBold async {
    try {
      return await _load(_getFontPath('Figtree-Bold'));
    } catch (e, t) {
      AppLogger.severe(
        'Error loading Figtree-Bold font: $e',
        error: e,
        stackTrace: t,
      );
      return null;
    }
  }

  static Future<ByteData?> get figtreeMedium async {
    try {
      return await _load(_getFontPath('Figtree-Medium'));
    } catch (e, t) {
      AppLogger.severe(
        'Error loading Figtree-Medium font: $e',
        error: e,
        stackTrace: t,
      );
      return null;
    }
  }

  static Future<ByteData?> get figtreeSemiBold async {
    try {
      return await _load(_getFontPath('Figtree-SemiBold'));
    } catch (e, t) {
      AppLogger.severe(
        'Error loading Figtree-SemiBold font: $e',
        error: e,
        stackTrace: t,
      );
      return null;
    }
  }

  static Future<void> clearCache() async {
    try {
      _fontCache.clear();
    } catch (e, t) {
      AppLogger.severe(
        'Error clearing font cache: $e',
        error: e,
        stackTrace: t,
      );
    }
  }
}
