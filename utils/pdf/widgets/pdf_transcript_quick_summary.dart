import 'package:pdf/widgets.dart';

import '../../utils.dart';

class PdfTranscriptQuickSummaryCard extends StatelessWidget {
  PdfTranscriptQuickSummaryCard({
    required this.textStyle,
    required this.quickSummary,
  });

  final String quickSummary;
  final PdfTextStyles textStyle;

  @override
  Widget build(Context context) {
    if (!quickSummary.hasValue) return SizedBox.shrink();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppPdfColors.palePurple, AppPdfColors.paleBlue],
          stops: const [0.4, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Quick Insights",
            style: textStyle.bannerHeading(),
          ),
          SizedBox(height: 10),
          Text(
            quickSummary,
            textDirection: quickSummary.pdfDirectionality,
            style: textStyle.textPlaceholder(
              color: AppPdfColors.secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
