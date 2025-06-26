import 'package:pdf/widgets.dart' as pw;

import 'package:blood_donor/widgets/pdf/pdf_checkbox.dart';

pw.Widget buildPdfLabeledCheckbox({required String label}) {
  return pw.Row(
    children: <pw.Widget>[
      buildPdfCheckbox(),
      pw.SizedBox(width: 4),
      pw.Text(label, style: pw.TextStyle(fontSize: 10)),
    ],
  );
}
