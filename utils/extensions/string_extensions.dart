import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pdf;

extension StringExtension on String {
  Uint8List get encoded => utf8.encode(this);

  DateTime? get asDate => DateTime.tryParse(this);

  int? get asInt => int.tryParse(this);

  String get isoDateOnly => split('T').first;
  String get isoTimeOnly => split('T').last;

  String get lower => toLowerCase();
  String get upper => toUpperCase();

  bool includes(String other) {
    return lower.contains(other.lower);
  }

  bool equals(String other) {
    return lower.trim() == other.lower.trim();
  }

  String concatenate(String other, {String concatenant = ''}) {
    return '$this$concatenant$other';
  }

  String get lastChars {
    if (isEmpty) return '';
    if (length <= 4) return this[length - 1];
    return substring(length - 4);
  }

  String capitalise({bool onlyFirst = false}) {
    final text = this;
    try {
      if (text.isEmpty) {
        return text;
      } else if (text.length == 1) {
        return text.toUpperCase();
      } else if (text.length > 1 && onlyFirst) {
        final firstChar = text[0];
        return '${firstChar.toUpperCase()}${text.substring(1).toLowerCase()}';
      } else {
        final textSpan = text.split(' ').map((it) {
          if (it.isEmpty) {
            return it;
          }
          if (it.length == 1) {
            return it.toUpperCase();
          }
          final firstChar = it[0];
          return '${firstChar.toUpperCase()}${it.substring(1).toLowerCase()}';
        });
        return textSpan.join(' ');
      }
    } catch (_) {
      return this;
    }
  }

  bool matches(String other) {
    return lower == other.lower;
  }
}

extension NullableStringExtension on String? {
  bool get hasValue {
    return this != null && (this ?? '').trim().isNotEmpty;
  }

  String get value => (this ?? '').trim();

  bool equals(String other) {
    if (this == null) return false;
    return this!.lower.trim() == other.lower.trim();
  }

  bool get isRTL {
    if (!hasValue) return false;
    final matchesRtl = AppRegex.rtlScriptRegex.hasMatch(this!);

    return matchesRtl;
  }

  pdf.TextDirection get pdfDirectionality {
    if (!isRTL) return pdf.TextDirection.ltr;
    return pdf.TextDirection.rtl;
  }
}

String randomNumString() {
  return '${Random().nextInt(100000000)}';
}

class AppRegex {
  static final mailRegEx = RegExp(
    r'\b[\w\d\W\D]+(?:@(?:[\w\d\W\D]+(?:\.(?:[\w\d\W\D]+))))\b',
  );
  static final starRegex = RegExp(r'\*$');
  static final syriacScriptRegex = RegExp(
    r'[\u0600-\u06FF\u0750-\u077F\uFB50-\uFDFF\uFE70-\uFEFF\u0591-\u05C7\u05D0-\u05EA\u05F0-\u05F4]',
    unicode: true,
  );
  static final rtlScriptRegex = RegExp(
    r'[\u0590-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]',
    unicode: true,
    multiLine: true,
  );
  static final passwordRegEx = RegExp(
    r'(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^a-zA-Z0-9]).{8,}',
  );
  static final specialCharRegEx = RegExp(r'[^A-Za-z0-9]+');
  static final eightCharRegEx = RegExp(r'.{8,}');
  static final phoneRegex = RegExp(r'^(\+[0-9]{1,4}\s)?[0-9]{5,15}$');
  static final imageRegex = RegExp(
    r'\.(gif|jp(e)?g|tif(f)?|png|webp|bmp|heic)$',
  );
  static final urlRegex = RegExp(
    r'^https?:\/\/(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)$',
  );
  static final xmlRegex = RegExp(r'<.+?>');
  static final jpegRegex = RegExp(r'\.jp(e)?g$', caseSensitive: false);
  static final audioFileRegex = RegExp(
    r'^.+(\.(mp4|mp3|aac|flac|aiff|wav|m4a))$',
    caseSensitive: false,
  );
  static final videoFileRegex = RegExp(
    r'^.+(\.(mp4|mov|avi|wmv|flv|webm|mkv|mpg|mpeg|m2v|vob|qt))$',
    caseSensitive: false,
  );
  static final audioMp4Regex = RegExp(r'^.+(\.(mp4))$', caseSensitive: false);
  static final audioMp3Regex = RegExp(r'^.+(\.(mp3))$', caseSensitive: false);
  static final audioM4aRegex = RegExp(r'^.+(\.(m4a))$', caseSensitive: false);
  static final audioAacRegex = RegExp(r'^.+(\.(aac))$', caseSensitive: false);
  static final audioFlacRegex = RegExp(r'^.+(\.(flac))$', caseSensitive: false);
  static final audioAiffRegex = RegExp(r'^.+(\.(aiff))$', caseSensitive: false);
  static final audioWavRegex = RegExp(r'^.+(\.(wav))$', caseSensitive: false);
  static final audioUrlRegex = RegExp(
    r'^https?:\/\/(.+\/)+.+(\.(mp4|mp3|aac|flac|aiff|wav|m4a))$',
    caseSensitive: false,
  );
  static final youtubeRegex = RegExp(
    r'^((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?$',
    multiLine: true,
  );
  static final customSchemeRegex = RegExp(
    r'(?<scheme>\w{1,3})(:\/)(?<path>\/[\w\W\d\D]{1,})',
    caseSensitive: false,
    multiLine: true,
  );
  static final hashTagRegex = RegExp(
    r'(?<text>\#[\w\d(_)]+\b)',
    multiLine: true,
    caseSensitive: false,
  );
  static final hashTagInputRegex = RegExp(
    r'^(\#)?[\w\d(_)]+\b',
    multiLine: true,
    caseSensitive: false,
  );
  static final lowercaseRegEx = RegExp(r'[a-z]+');
  static final uppercaseRegEx = RegExp(r'[A-Z]+');
  static final globalUrlRegEx = RegExp(
    r'https?:\/\/(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)',
    caseSensitive: false,
    multiLine: true,
  );
  static final xmlRegEx = RegExp(
    r'((<\w+>(.*)?<\/\w+>)|<\w+>|(<\s*\/?[^>]*>))',
    caseSensitive: false,
    multiLine: true,
  );
  static final digitRegEx = RegExp(r'\d+');
  static final videoRegex = RegExp(
    r'\.(flv|webm|mkv|vob|ogv|ogg|drc|mp4|drc|avi|mov|qt|mts|ts|m2ts|wmv|amv|m4p|m4v|mpg|mpeg|mp2|mpe|mpv|flv|m4v|svi|3gp|3g2|f4v|f4p|f4a|f4b)$',
    caseSensitive: false,
  );
  static final transcriptDetailRegex = RegExp(
    r'\/dashboard\/transcript\/(?<uuid>[0-9a-f]{8}-[0-9a-f]{4}-[0-5][0-9a-f]{3}-[089ab][0-9a-f]{3}-[0-9a-f]{12})',
  );

  static String getMatchGroupValue({
    required RegExp pattern,
    required String input,
    required String group,
  }) {
    if (!pattern.hasMatch(input)) return '';
    final match = pattern.firstMatch(input);
    return match?.namedGroup(group) ?? '';
  }
}
