import 'package:dart_frog/dart_frog.dart';
import '../../utils/utils.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: 405, body: "Method Not Allowed");
  }

  PdfTranscriptSummary summary;

  try {
    final payload = await context.request.json() as Map<String, dynamic>;
    summary = PdfTranscriptSummary.fromJson(payload);
  } catch (e, t) {
    AppLogger.severe("Error parsing request body: $e", error: e, stackTrace: t);
    return Response(
      statusCode: 400,
      body: "Failed to generate PDF summary: Invalid request body.",
    );
  }

  final bytes = await PdfService.pdfForSummary(summary);

  if (bytes == null) {
    return Response(
      statusCode: 500,
      body: "Failed to generate PDF summary: Internal error.",
    );
  }

  String fileName = "${summary.title}_transcribr_transcript_summary.pdf";
  fileName = Uri.encodeComponent(fileName);

  return Response.bytes(
    body: bytes,
    headers: {
      "Content-Type": "application/pdf",
      "Content-Disposition": "attachment; filename=$fileName",
    },
  );
}
