import 'package:dart_frog/dart_frog.dart';

import '../../utils/utils.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: 405, body: "Method Not Allowed");
  }

  PdfTranscript transcript;

  try {
    final payload = await context.request.json() as Map<String, dynamic>;
    transcript = PdfTranscript.fromJson(payload);
  } catch (e, t) {
    AppLogger.severe("Error parsing request body: $e", error: e, stackTrace: t);
    return Response(
      statusCode: 400,
      body: "Failed to generate PDF summary: Invalid request body.",
    );
  }

  final bytes = await PdfService.pdfFromSections(transcript);

  if (bytes == null) {
    return Response(
      statusCode: 500,
      body: "Failed to generate PDF transcript: Internal error.",
    );
  }

  final fileName = "${transcript.title}_transcribr_transcript.pdf";

  return Response.bytes(
    body: bytes,
    headers: {
      "Content-Type": "application/pdf",
      "Content-Disposition": "attachment; filename=$fileName",
    },
  );
}
