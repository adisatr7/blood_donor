import 'package:blood_donor/models/db/appointment.dart';
import 'package:blood_donor/models/db/user.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';


Widget questionnairePdfPreviewA4(User? user, Appointment? appointment) {
  return PdfPreview(
    initialPageFormat: PdfPageFormat.a4.landscape,
    maxPageWidth: 1200,
    pdfFileName: 'questionnaire_a4_landscape.pdf',
    build: (format) async {
      final pdf = pw.Document();

      // First page
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4.landscape,
          build: (context) => pw.Center(
            child: pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.red, width: 2),
              ),
              padding: const pw.EdgeInsets.all(16),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Page 1'),
                  pw.SizedBox(height: 16),
                  pw.TableHelper.fromTextArray(
                    headers: ['No', 'Pertanyaan', 'Jawaban'],
                    data: [
                      ['1', 'Apakah Anda pernah mengalami demam tinggi dalam 3 hari terakhir?', 'Tidak'],
                      ['2', 'Apakah Anda memiliki riwayat penyakit jantung?', 'Ya'],
                      ['3', 'Apakah Anda sedang mengonsumsi obat-obatan tertentu?', 'Tidak'],
                      // Add more rows as needed
                    ],
                    headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    cellAlignment: pw.Alignment.centerLeft,
                    cellStyle: pw.TextStyle(fontSize: 10),
                    border: pw.TableBorder.all(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Second page (for demonstration, same data)
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4.landscape,
          build: (context) => pw.Center(
            child: pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.red, width: 2),
              ),
              padding: const pw.EdgeInsets.all(16),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Page 2'),
                  pw.SizedBox(height: 16),
                  pw.TableHelper.fromTextArray(
                    headers: ['No', 'Pertanyaan', 'Jawaban'],
                    data: [
                      ['1', 'Apakah Anda pernah mengalami demam tinggi dalam 3 hari terakhir?', 'Tidak'],
                      ['2', 'Apakah Anda memiliki riwayat penyakit jantung?', 'Ya'],
                      ['3', 'Apakah Anda sedang mengonsumsi obat-obatan tertentu?', 'Tidak'],
                      // Add more rows as needed
                    ],
                    headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    cellAlignment: pw.Alignment.centerLeft,
                    cellStyle: pw.TextStyle(fontSize: 10),
                    border: pw.TableBorder.all(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      return pdf.save();
    },
  );
}

// !-- Jangan hapus kode di bawah ini --!

// Keep your original savePdf for printing/sharing
// Future<void> savePdf(User? user, Appointment? appointment) async {
//   final pdf = pw.Document();

//   // Halaman pertama
//   pdf.addPage(
//     pw.Page(
//       pageFormat: PdfPageFormat.a4.landscape,
//       build: (context) => pw.Center(
//         child: pw.Container(
//           decoration: pw.BoxDecoration(
//             border: pw.Border.all(color: PdfColors.red, width: 2),
//           ),
//           padding: const pw.EdgeInsets.all(16),
//           child: pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.SizedBox(height: 16),
//               pw.TableHelper.fromTextArray(
//                 headers: ['No', 'Pertanyaan', 'Jawaban'],
//                 data: [['questionnaireAnswers']],
//                 headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                 cellAlignment: pw.Alignment.centerLeft,
//                 cellStyle: pw.TextStyle(fontSize: 10),
//                 border: pw.TableBorder.all(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );

//   await Printing.layoutPdf(
//     onLayout: (PdfPageFormat format) async => pdf.save(),
//   );
// }