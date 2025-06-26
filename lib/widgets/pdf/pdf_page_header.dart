import 'package:pdf/widgets.dart' as pw;

pw.Widget buildPdfPageHeader({int pageNumber = 1, pw.Widget? subheader}) {
  return pw.Column(
    children: [
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'UDD PMI Kabupaten Banyumas',
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'Formulir Kuesioner dan Informed Consent Donor',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
          pw.Text(
            'Halaman $pageNumber dari 2',
            style: pw.TextStyle(fontSize: 10),
          ),
        ],
      ),
      pw.Divider(thickness: 1.5),

      if (subheader != null)
        pw.Center(child: subheader),
    ],
  );
}
