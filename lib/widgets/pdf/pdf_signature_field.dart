import 'package:pdf/widgets.dart' as pw;

pw.Widget buildPdfSignatureField({required String label}) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.center,
    children: [
      pw.Text(label, style: pw.TextStyle(fontSize: 10)),
      pw.SizedBox(height: 40),
      pw.Text('__________________________', style: pw.TextStyle(fontSize: 10)),
    ],
  );
}
