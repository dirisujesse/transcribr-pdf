import '../../../utils.dart';

class PdfTranscript {
  final String title;
  final String subTitle;
  final String plainText;
  final bool isProUser;
  final List<PdfSection>? sections;

  PdfTranscript({
    required this.title,
    required this.subTitle,
    required this.plainText,
    required this.isProUser,
    this.sections,
  });

  factory PdfTranscript.fromJson(Map<String, dynamic> json) {
    try {
      return PdfTranscript(
        title: json["title"] as String,
        subTitle: json["sub_title"] as String,
        plainText: json["plain_text"] as String,
        isProUser: json["is_pro_user"] as bool,
        sections: (json["sections"] as List?).mapList(
          (x) => PdfSection.fromJson(x as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      throw FormatException("Error parsing PdfTranscript: $e");
    }
  }
}

class PdfSection {
  final String text;
  final String? header;
  final String? headerTrailing;

  PdfSection({
    required this.text,
    this.header,
    this.headerTrailing,
  });

  factory PdfSection.fromJson(Map<String, dynamic> json) => PdfSection(
        text: json['text'] as String,
        header: json['header'] as String?,
        headerTrailing: json['header_trailing'] as String?,
      );
}
