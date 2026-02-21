import '../../../utils.dart';

class PdfTranscriptSummary {
  final String? summaryOverview;
  final List<PdfKeyTopic>? keyTopics;
  final String? decisionsAndFindings;
  final List<String>? actionableTakeaways;
  final List<String>? participants;
  final String title;
  final String quickSummary;
  final String duration;
  final bool isProUser;

  PdfTranscriptSummary({
    required this.title,
    required this.quickSummary,
    required this.duration,
    required this.isProUser,
    this.summaryOverview,
    this.keyTopics,
    this.decisionsAndFindings,
    this.actionableTakeaways,
    this.participants,
  });

  factory PdfTranscriptSummary.fromJson(Map<String, dynamic> json) {
    try {
      return PdfTranscriptSummary(
        title: json["title"] as String,
        quickSummary: json["quick_summary"] as String,
        duration: json["duration"] as String,
        isProUser: json["is_pro_user"] as bool,
        summaryOverview: json["summary_overview"] as String?,
        keyTopics: (json["key_topics"] as List?).mapList(
          (x) => PdfKeyTopic.fromJson(x as Map<String, dynamic>),
        ),
        decisionsAndFindings: json["decisions_and_findings"] as String?,
        actionableTakeaways: (json["actionable_takeaways"] as List?).mapList(
          (x) => x as String,
        ),
        participants: (json["participants"] as List?).mapList(
          (x) => x as String,
        ),
      );
    } catch (e) {
      throw FormatException("Error parsing PdfTranscriptSummary: $e");
    }
  }
}

class PdfKeyTopic {
  final String? topic;
  final String? explanation;

  PdfKeyTopic({this.topic, this.explanation});
  factory PdfKeyTopic.fromJson(Map<String, dynamic> json) => PdfKeyTopic(
        topic: json['topic'] as String?,
        explanation: json['explanation'] as String?,
      );
}
