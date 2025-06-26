import 'package:pdf/widgets.dart' as pw;

import 'package:blood_donor/widgets/pdf/pdf_form_header.dart';
import 'package:blood_donor/widgets/pdf/pdf_checkbox_group.dart';

pw.Widget buildPdfAdministrationForm() {
  return pw.Container(
    height: 290,
    width: double.infinity,
    decoration: pw.BoxDecoration(
      border: pw.Border(bottom: pw.BorderSide(width: 0.5)),
    ),
    child: pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          buildPdfFormHeader(title: 'DIISI OLEH ADMINISTRASI PENDAFTARAN'),
          pw.SizedBox(height: 10),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                children: [
                  pw.Container(
                    width: 180,
                    child: pw.Text(
                      "Validasi Data Pendonor: ",
                      style: pw.TextStyle(fontSize: 10),
                    ),
                  ),
                  buildPdfCheckboxGroup(labels: ['Kartu Pendonor']),
                ],
              ),

              ...['KTP', 'SIM', 'Kartu Pelajar / Mahasiswa', 'Paspor'].map(
                (item) => pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 10),
                  child: pw.Row(
                    children: [
                      pw.Container(width: 180),
                      buildPdfCheckboxGroup(labels: [item]),
                    ],
                  ),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 40),

          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "Riwayat Donor Sebelumnya",
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.Text(
                "Tanda Tangan Petugas",
                style: pw.TextStyle(fontSize: 10),
              ),
            ],
          ),
          pw.SizedBox(height: 40),

          pw.Text(
            "..................................................................................................",
            style: pw.TextStyle(fontSize: 10),
          ),
          pw.SizedBox(height: 10),

          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "..................................................................................................",
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.Text(
                ".....................................",
                style: pw.TextStyle(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
