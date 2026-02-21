import 'package:pdf/widgets.dart';

import '../../utils.dart';

class PdfTextTile extends StatelessWidget {
  PdfTextTile(this.line, {required this.textStyle});

  final String line;
  final PdfTextStyles textStyle;

  

  @override
  Widget build(Context context) {
    return Directionality(
      textDirection: line.pdfDirectionality,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("-"),
          SizedBox(width: 8),
          Expanded(child: PdfText(line, textStyle: textStyle)),
        ],
      ),
    );
  }
}

class PdfText extends StatelessWidget {
  PdfText(this.text, {required this.textStyle});

  final String text;
  final PdfTextStyles textStyle;

  @override
  Widget build(Context context) {
    return Directionality(
      textDirection: text.pdfDirectionality,
      child: Paragraph(
        text: text,
        textAlign: TextAlign.start,
        style: textStyle.callout(color: AppPdfColors.secondaryTextColor),
      ),
    );
  }
}

class PdfTitle extends StatelessWidget {
  PdfTitle(this.text, {required this.textStyle});

  final String text;
  final PdfTextStyles textStyle;

  @override
  Widget build(Context context) {
    return Text(
      text,
      style: textStyle.bannerHeading(),
      textDirection: text.pdfDirectionality,
    );
  }
}

class PdfSubtitle extends StatelessWidget {
  PdfSubtitle(this.text, {required this.textStyle});
  
  final String text;
  final PdfTextStyles textStyle;

  @override
  Widget build(Context context) {
    return Text(
      text,
      style: textStyle.subHead1(),
      textDirection: text.pdfDirectionality,
    );
  }
}
