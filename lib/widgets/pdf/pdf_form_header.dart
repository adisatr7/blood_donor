import 'package:pdf/widgets.dart' as pw;

pw.Widget buildPdfFormHeader({String title = ''}) {
  return pw.Text(
    title,
    style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
  );
}
