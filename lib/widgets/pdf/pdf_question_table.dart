import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import 'package:blood_donor/models/db/appointment.dart';
import 'package:blood_donor/models/db/questionnaire.dart';

/// Method internal untuk membantu menghitung jumlah baris yang ada di setiap section
int _countTotalRows(sum, section) => sum + section.items.length;

/// Membuat header tabel dengan judul yang diberikan.
/// Jika [isCenterAligned] true, teks akan diratakan ke tengah; jika tidak,
/// teks akan diratakan ke kiri.
pw.Widget _buildTableHeader(String title, {bool isCenterAligned = false}) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(2),
    child: pw.Text(
      title,
      style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
      textAlign: isCenterAligned ? pw.TextAlign.center : pw.TextAlign.left,
    ),
  );
}

/// Builder untuk kolom checklist di tabel.
/// Jika [checked] true, akan menampilkan ikon centang; jika tidak, hanya kotak kosong.
pw.Widget _buildChecklistCell({
  required bool checked,
  required pw.MemoryImage? checkIcon,
  double size = 8,
}) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 2),
    child: pw.Center(
      child: pw.Stack(
        alignment: pw.Alignment.center,
        children: [
          pw.Container(
            width: size,
            height: size,
            decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.5)),
          ),
          if (checked && checkIcon != null)
            pw.Image(checkIcon, width: size + 2, height: size + 2),
        ],
      ),
    ),
  );
}

pw.Widget buildPdfQuestionTable({
  required List<QuestionnaireSection> sections,
  required List<AppointmentQuestionnaire> answers,
  required pw.MemoryImage checkIcon,
  bool isLeftColumn = true,
}) {
  // Hitung jumlah baris total dari semua section
  int totalRows = sections.fold(0, _countTotalRows);
  int halfRows = (totalRows / 2).ceil();

  return pw.Table(
    // Style garis tabel
    border: pw.TableBorder(
      left: pw.BorderSide(width: 0.5),
      right: pw.BorderSide(width: 0.5),
      top: pw.BorderSide(width: 0.5),
      bottom: pw.BorderSide(width: 0.5),
      verticalInside: pw.BorderSide(width: 0.5),
      horizontalInside: pw.BorderSide.none,
    ),

    // Daftar kolom pada tabel
    columnWidths: {
      0: const pw.FixedColumnWidth(25), // No
      1: const pw.FlexColumnWidth(8), // Pertanyaan
      2: const pw.FixedColumnWidth(25), // Ya
      3: const pw.FixedColumnWidth(25), // Tidak
      4: const pw.FixedColumnWidth(80), // Diisi Petugas
    },

    children: [
      pw.TableRow(
        decoration: pw.BoxDecoration(
          color: PdfColors.grey200,
          border: pw.Border(bottom: pw.BorderSide(width: 0.5)),
        ),
        children: [
          _buildTableHeader('No', isCenterAligned: true),
          _buildTableHeader('Pertanyaan'),
          _buildTableHeader('Ya', isCenterAligned: true),
          _buildTableHeader('Tidak', isCenterAligned: true),
          _buildTableHeader('Diisi Petugas', isCenterAligned: true),
        ],
      ),
      // Data rows
      ...sections.expand((section) {
        final List<pw.TableRow> rows = [];
        final items = section.items;

        // Filter items berdasarkan posisi kolom
        final column =
            items.where((item) {
              final rowIndex = item.itemNumber - 1;
              return isLeftColumn ? rowIndex < halfRows : rowIndex >= halfRows;
            }).toList();

        if (column.isNotEmpty) {
          // Add section header
          rows.add(
            pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColors.grey100),
              children: [
                pw.Container(), // Cell kosong untuk `No.`
                pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    section.title,
                    style: pw.TextStyle(
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Container(), // Cell kosong untuk `Ya`
                pw.Container(), // Cell kosong untuk `Tidak`
                pw.Container(), // Cell kosong untuk `Diisi Petugas`
              ],
            ),
          );

          rows.addAll(
            column.asMap().entries.map(
              (entry) => pw.TableRow(
                children: [
                  // Nomor
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 4,
                    ),
                    child: pw.Text(
                      entry.value.itemNumber.toString(),
                      style: const pw.TextStyle(fontSize: 8),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),

                  // Pertanyaan
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 4,
                    ),
                    child: pw.Text(
                      entry.value.question,
                      style: const pw.TextStyle(fontSize: 8),
                    ),
                  ),

                  // Kotak `Ya`
                  _buildChecklistCell(
                    checked: answers[entry.key].isYes,
                    checkIcon: checkIcon,
                  ),

                  // Kotak `Tidak`
                  _buildChecklistCell(
                    checked: answers[entry.key].isNo,
                    checkIcon: checkIcon,
                  ),

                  // Kolom `Diisi Petugas`
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 4,
                    ),
                    child: pw.Text(
                      '.............................',
                      style: const pw.TextStyle(fontSize: 8),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return rows;
      }),
    ],
  );
}
