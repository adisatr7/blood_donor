import 'package:pdf/widgets.dart' as pw;

pw.Widget buildPdfField({
  required String label,
  String value = '',
  double labelWidth = 120.0,
  bool showDots = false,
}) => pw.Row(
  children: [
    pw.SizedBox(
      width: labelWidth,
      child: pw.Text(label, style: pw.TextStyle(fontSize: 10)),
    ),
    pw.Text(': ', style: pw.TextStyle(fontSize: 10)),
    pw.Text(
      showDots ? '............................................. $value' : value,
      style: pw.TextStyle(fontSize: 10),
    ),
  ],
);
