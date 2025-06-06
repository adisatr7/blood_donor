import 'dart:developer';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'package:blood_donor/constants/questionnaire_list.dart';

// Helper widgets untuk membuat komponen yang sering digunakan
pw.Widget _buildCheckbox() {
  return pw.Container(
    width: 10,
    height: 10,
    decoration: pw.BoxDecoration(
      border: pw.Border.all(width: 0.5),
    ),
  );
}

pw.Widget _buildLabeledCheckbox(String label) {
  return pw.Row(
    children: [
      _buildCheckbox(),
      pw.SizedBox(width: 4),
      pw.Text(
        label,
        style: pw.TextStyle(fontSize: 10),
      ),
    ],
  );
}

pw.Widget _buildFormField(String label, {String value = '', double labelWidth = 120}) {
  return pw.Row(
    children: [
      pw.SizedBox(
        width: labelWidth,
        child: pw.Text(
          label,
          style: pw.TextStyle(fontSize: 10),
        ),
      ),
      pw.Text(
        ': $value',
        style: pw.TextStyle(fontSize: 10),
      ),
    ],
  );
}

pw.Widget _buildFormFieldWithDots(String label, {String suffix = '', double labelWidth = 120, bool? showDots}) {
  return pw.Row(
    children: [
      pw.SizedBox(
        width: labelWidth,
        child: pw.Text(
          label,
          style: pw.TextStyle(fontSize: 10),
        ),
      ),
      pw.Text(
        ': ',
        style: pw.TextStyle(fontSize: 10),
      ),
      pw.Text(
        showDots == false ? suffix : '............................................. $suffix',
        style: pw.TextStyle(fontSize: 10),
      ),
    ],
  );
}

pw.Widget _buildSignatureField(String label) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.center,
    children: [
      pw.Text(
        label,
        style: pw.TextStyle(fontSize: 10),
      ),
      pw.SizedBox(height: 40),
      pw.Text(
        '__________________________',
        style: pw.TextStyle(fontSize: 10),
      ),
    ],
  );
}

pw.Widget _buildCheckboxGroup(List<String> options, {double spacing = 10}) {
  return pw.Row(
    children: options.expand((option) => [
      _buildLabeledCheckbox(option),
      pw.SizedBox(width: spacing),
    ]).toList()..removeLast(),
  );
}

pw.Widget _buildSectionHeader(String title) {
  return pw.Text(
    title,
    style: pw.TextStyle(
      fontSize: 10,
      fontWeight: pw.FontWeight.bold,
    ),
  );
}

// Fungsi untuk mengkonversi data kuesioner ke format yang bisa dibaca PDF
List<Map<String, dynamic>> convertQuestionnaireData() {
  final List<Map<String, dynamic>> result = [];
  int totalRows = 0;

  for (var section in allQuestions.sections) {
    final Map<String, dynamic> sectionMap = {
      'title': section.title,
      'items':
          section.items
              .map(
                (item) => {
                  'itemNumber': item.itemNumber,
                  'question': item.question,
                  'rowIndex': totalRows++, // Tambahkan index baris
                },
              )
              .toList(),
    };
    result.add(sectionMap);
  }

  return result;
}

Widget questionnairePdfPreviewA4() {
  return PdfPreview(
    initialPageFormat: PdfPageFormat.a3.landscape,
    maxPageWidth: 1200,
    build: (format) async {
      final pdf = pw.Document();
      final questionnaireData = convertQuestionnaireData();
      log('Debug - Questionnaire Data: $questionnaireData');

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a3.landscape,
          margin: const pw.EdgeInsets.all(24),
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Formulir Kuesioner dan Informed Consent Donor',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'Halaman 1 dari 2',
                      style: pw.TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                pw.Divider(thickness: 1.5),
                pw.Center(
                  child: pw.Text(
                    'Selamat Datang, Terima Kasih Atas Kesediaan Anda Meluangkan Waktu Untuk Menyumbangkan Darah',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Center(
                  child: pw.Text(
                    'Mohon Formulir ini Diisi Dengan Sejujurnya Untuk Keselamatan Anda dan Calon Penerima Darah Anda',
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ),

                pw.SizedBox(height: 16),
                // Form header
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      flex: 2,
                      child: pw.Table(
                            border: pw.TableBorder.all(width: 0.5),
                            children: [
                              pw.TableRow(
                                children: [
                                  pw.Padding(
                                    padding: const pw.EdgeInsets.all(4),
                                    child: pw.Text(
                                      'Tempat Penyumbangan:',
                                      style: pw.TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  pw.Padding(
                                    padding: const pw.EdgeInsets.all(4),
                                    child: pw.Text(
                                      'UDD PMI Kabupaten Banyumas',
                                      style: pw.TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  pw.Padding(
                                    padding: const pw.EdgeInsets.all(4),
                                    child: pw.Text(
                                      'Tanggal Donor:',
                                      style: pw.TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  pw.Padding(
                                    padding: const pw.EdgeInsets.all(4),
                                    child: pw.Text(
                                      '20 April 2025',
                                      style: pw.TextStyle(fontSize: 10),
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                pw.SizedBox(height: 8),
                // Form biodata
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 8),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            _buildFormField('No. KTP / Paspor (WNA)', value: '3301234567890123', labelWidth: 150),
                            _buildFormField('Nama Lengkap', value: 'Rizky Ageng Nugroho', labelWidth: 150),
                            _buildFormField('Tempat, Tanggal Lahir', value: 'Cilacap, 12/10/2003', labelWidth: 150),
                            _buildFormField('Umur', value: '21 Tahun', labelWidth: 150),
                            _buildFormField('Jenis Kelamin', value: 'Laki-laki', labelWidth: 150),
                            pw.SizedBox(height: 4),
                            pw.Row(
                              children: [
                                pw.Text(
                                  'Penghargaan yang telah diterima: ',
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                                _buildCheckboxGroup(['10x', '25x', '50x', '75x', '100x']),
                              ],
                            ),
                            pw.SizedBox(height: 4),
                            pw.Row(
                              children: [
                                pw.Text(
                                  'Bersediakah saudara donor pada waktu bulan puasa: ',
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                                _buildCheckboxGroup(['Ya', 'Tidak']),
                              ],
                            ),
                            pw.SizedBox(height: 4),
                            pw.Row(
                              children: [
                                pw.Text(
                                  'Bersediakah saudara donor saat dibutuhkan untuk komponen darah tertentu: ',
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                                _buildCheckboxGroup(['Ya', 'Tidak']),
                              ],
                            ),
                            pw.SizedBox(height: 4),
                            pw.Text(
                              'Donor yang terakhir tanggal:................................................ sekarang donor yang ke : 15 kali',
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            _buildFormField('No. Kartu Donor', value: '0000000000000000'),
                            _buildFormField('Pekerjaan', value: 'CEO Google LLC'),
                            _buildFormField('Alamat', value: 'Jl. Raya Cilacap No. 123'),
                            _buildFormField('Kel. / Kec.', value: 'Rawajaya / Bantarsari'),
                            _buildFormField('Wilayah', value: 'Cilacap'),
                            _buildFormField('No. HP', value: '081234567890'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 16),

                // Header text
                pw.Row(
                  children: [
                    pw.Text(
                      'Pilih dan Lengkapi Jawaban Anda dengan Tanda ',
                      style: pw.TextStyle(fontSize: 10),
                    ),
                    pw.Image(
                      pw.MemoryImage(
                        File('assets/icons/check.png').readAsBytesSync(),
                      ),
                      width: 8,
                      height: 8,
                    ),
                    pw.Text(' atau Tidak', style: pw.TextStyle(fontSize: 8)),
                  ],
                ),
                pw.SizedBox(height: 4),

                // Bagi data menjadi 2 kolom sejajar
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Kolom Kiri (setengah dari total baris)
                    pw.Expanded(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(right: 5),
                        child: _buildQuestionTable(
                          questionnaireData,
                          true,
                        ), // parameter true untuk kolom kiri
                      ),
                    ),
                    // Kolom Kanan (setengah dari total baris)
                    pw.Expanded(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 5),
                        child: _buildQuestionTable(
                          questionnaireData,
                          false,
                        ), // parameter false untuk kolom kanan
                      ),
                    ),
                  ],
                ),

                pw.SizedBox(height: 12),

                // Teks persetujuan
                pw.SizedBox(
                  width: 700,
                  child: pw.Text(
                    "Saya telah mendapatkan dan membaca semua informasi yang diberikan serta menjawab pertanyaan dengan jujur. Saya mengerti dan bersedia menyumbangkan darah dengan volume sesuai standar yang diberlakukan dan setuju diambil contoh darahnya untuk keperluan pemeriksaan laboratorium berupa uji darah, HIV, Hepatitis B, Hepatitis C, Sifilis, dan infeksi lainnya yang diperlukan serta untuk kepentingan penelitian. Bila ternyata hasil pemeriksaan laboratorium perlu ditindaklanjuti, maka saya setuju untuk diberi kabar tertulis. Jika komponen plasma tidak terpakai untuk transfusi, saya setuju dapat dijadikan produk plasma untuk pengobatan.",
                    style: pw.TextStyle(fontSize: 8),
                    textAlign: pw.TextAlign.justify,
                  ),
                ),

                pw.SizedBox(height: 12),

                // Tanda tangan sebelahan
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          'Tanda Tangan Petugas:',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(height: 40),
                        pw.Text(
                          '__________________________',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    pw.SizedBox(width: 80),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          'Tanda Tangan Pendonor:',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(height: 40),
                        pw.Text(
                          '__________________________',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );

      // Halaman 2
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a3.landscape,
          margin: const pw.EdgeInsets.all(24),
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
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
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    pw.Text(
                      'Halaman 2 dari 2',
                      style: pw.TextStyle(fontSize: 10),
                    ),
                  ],
                ),

                pw.SizedBox(height: 4),
                pw.Divider(thickness: 1.5),
                pw.SizedBox(height: 4),

                pw.Center(
                  child: pw.Text(
                    'MOHON DIISI LENGKAP MENGGUNAKAN HURUF KAPITAL',
                    style: pw.TextStyle(
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 8),

                // Tabel Header
                pw.Table(
                  border: pw.TableBorder.all(width: 0.5),
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(
                            'Tempat Penyumbangan:',
                            style: pw.TextStyle(fontSize: 10),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(
                            'UDD PMI Kabupaten Banyumas',
                            style: pw.TextStyle(fontSize: 10),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(
                            'Tanggal Donor:',
                            style: pw.TextStyle(fontSize: 10),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(
                            '25 April 2025',
                            style: pw.TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                pw.SizedBox(height: 8),

                // Tabel Utama dengan 3 Bagian
                pw.Table(
                  border: pw.TableBorder.all(width: 0.5),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(1), // Kolom kiri
                    1: const pw.FlexColumnWidth(1), // Kolom kanan
                  },
                  children: [
                    pw.TableRow(
                      children: [
                        // Kolom Kiri (2 bagian vertikal)
                        pw.Container(
                          height: 693,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              // Bagian Atas
                              _buildAdministrationSection(),
                              _buildAftapSection(),
                            ],
                          ),
                        ),
                        // Kolom Kanan (1 bagian)
                        pw.Container(
                          height: 600,
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                _buildSectionHeader('DIISI OLEH PETUGAS MEDICAL CHECKUP'),
                                pw.SizedBox(height: 10),
                                pw.Row(
                                  children: [
                                    pw.SizedBox(
                                      width: 120,
                                      child: pw.Text(
                                        'Jenis Donor',
                                        style: pw.TextStyle(fontSize: 10),
                                      ),
                                    ),
                                    pw.Text(
                                      ': ',
                                      style: pw.TextStyle(fontSize: 10),
                                    ),
                                    _buildCheckboxGroup(['Sukarela', 'Pengganti']),
                                  ],
                                ),
                                pw.SizedBox(height: 10),
                                pw.Row(
                                  children: [
                                    pw.SizedBox(
                                      width: 120,
                                      child: pw.Text(
                                        'Metode Pengambilan',
                                        style: pw.TextStyle(fontSize: 10),
                                      ),
                                    ),
                                    pw.Text(
                                      ': ',
                                      style: pw.TextStyle(fontSize: 10),
                                    ),
                                    _buildCheckboxGroup(['Biasa', 'Apheresis', 'Autologus']),
                                  ],
                                ),
                                pw.SizedBox(height: 10),
                                pw.Row(
                                  children: [
                                    pw.SizedBox(
                                      width: 120,
                                      child: pw.Text(
                                        'Golongan Darah',
                                        style: pw.TextStyle(fontSize: 10),
                                      ),
                                    ),
                                    pw.Text(
                                      ': ',
                                      style: pw.TextStyle(fontSize: 10),
                                    ),
                                    _buildCheckboxGroup(['A', 'B', 'AB', 'O']),
                                  ],
                                ),
                                pw.SizedBox(height: 10),
                                pw.Row(
                                  children: [
                                    pw.SizedBox(
                                      width: 120,
                                      child: pw.Text(
                                        'Rhesus Darah',
                                        style: pw.TextStyle(fontSize: 10),
                                      ),
                                    ),
                                    pw.Text(
                                      ': ',
                                      style: pw.TextStyle(fontSize: 10),
                                    ),
                                    _buildCheckboxGroup(['Positif', 'Negatif']),
                                  ],
                                ),
                                pw.SizedBox(height: 10),
                                _buildFormFieldWithDots('Berat Badan', suffix: 'Kg'),
                                pw.SizedBox(height: 10),
                                _buildFormFieldWithDots('Tinggi Badan', suffix: 'cm'),
                                pw.SizedBox(height: 10),
                                _buildFormFieldWithDots('Nilai Hemoglobin', suffix: 'g/dL'),
                                pw.SizedBox(height: 10),
                                _buildFormFieldWithDots('Tekanan Darah', suffix: 'mmHg'),
                                pw.SizedBox(height: 10),
                                _buildFormFieldWithDots('Denyut Nadi', suffix: 'x/menit'),
                                pw.SizedBox(height: 10),
                                _buildFormFieldWithDots('Suhu', suffix: '°C'),
                                pw.SizedBox(height: 10),
                                _buildFormFieldWithDots('Riwayat Medis'),
                                pw.SizedBox(height: 10),
                                _buildFormFieldWithDots('Keadaan Umum'),
                                pw.SizedBox(height: 10),
                                pw.Row(
                                  children: [
                                    pw.SizedBox(
                                      width: 120,
                                      child: pw.Text(
                                        'Status',
                                        style: pw.TextStyle(fontSize: 10),
                                      ),
                                    ),
                                    pw.Text(
                                      ': ',
                                      style: pw.TextStyle(fontSize: 10),
                                    ),
                                    _buildCheckboxGroup(['Diterima', 'Ditolak']),
                                  ],
                                ),
                                pw.SizedBox(height: 50),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildSignatureField('Keterangan (jika ada)'),
                                    _buildSignatureField('Tanda Tangan Petugas'),
                                  ],
                                        ),
                                      ],
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );

      return pdf.save();
    },
  );
}

// Fungsi helper untuk membuat tabel
pw.Widget _buildQuestionTable(
  List<Map<String, dynamic>> sectionData,
  bool isLeftColumn,
) {
  // Hitung total baris
  int totalRows = sectionData.fold(
    0,
    (sum, section) => sum + (section['items'] as List).length,
  );
  int halfRows = (totalRows / 2).ceil();

  return pw.Table(
    border: pw.TableBorder(
      left: pw.BorderSide(width: 0.5),
      right: pw.BorderSide(width: 0.5),
      top: pw.BorderSide(width: 0.5),
      bottom: pw.BorderSide(width: 0.5),
      verticalInside: pw.BorderSide(width: 0.5),
      horizontalInside: pw.BorderSide.none,
    ),
    columnWidths: {
      0: const pw.FixedColumnWidth(25), // No
      1: const pw.FlexColumnWidth(8), // Pertanyaan
      2: const pw.FixedColumnWidth(25), // Ya
      3: const pw.FixedColumnWidth(25), // Tidak
      4: const pw.FixedColumnWidth(80), // Diisi Petugas
    },
    children: [
      // Header row
      pw.TableRow(
        decoration: pw.BoxDecoration(
          color: PdfColors.grey200,
          border: pw.Border(bottom: pw.BorderSide(width: 0.5)),
        ),
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.all(2),
            child: pw.Text(
              'No',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(2),
            child: pw.Text(
              'Pertanyaan',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(2),
            child: pw.Text(
              'Ya',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(2),
            child: pw.Text(
              'Tidak',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(2),
            child: pw.Text(
              'Diisi Petugas',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      // Data rows
      ...sectionData.expand((section) {
        final List<pw.TableRow> rows = [];
        final items = section['items'] as List;

        // Filter items berdasarkan posisi kolom
        final filteredItems =
            items.where((item) {
              final rowIndex = item['rowIndex'] as int;
              return isLeftColumn ? rowIndex < halfRows : rowIndex >= halfRows;
            }).toList();

        if (filteredItems.isNotEmpty) {
          // Add section header
          rows.add(
            pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColors.grey100),
              children: [
                pw.Container(), // Empty cell for number
                pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    section['title'] as String,
                    style: pw.TextStyle(
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Container(), // Empty cell for Ya
                pw.Container(), // Empty cell for Tidak
                pw.Container(), // Empty cell for Diisi Petugas
              ],
            ),
          );

          // Add question rows
          rows.addAll(
            filteredItems.map(
              (item) => pw.TableRow(
                children: [
                  // Nomor
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 4,
                    ),
                    child: pw.Text(
                      (item['itemNumber'] as int).toString(),
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
                      item['question'] as String,
                      style: const pw.TextStyle(fontSize: 8),
                    ),
                  ),
                  // Kotak Ya
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 2),
                    child: pw.Center(
                      child: pw.Container(
                        width: 8,
                        height: 8,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(width: 0.5),
                        ),
                      ),
                    ),
                  ),
                  // Kotak Tidak
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 2),
                    child: pw.Center(
                      child: pw.Container(
                        width: 8,
                        height: 8,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(width: 0.5),
                        ),
                      ),
                    ),
                  ),
                  // Kolom Diisi Petugas
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
      }).toList(),
    ],
  );
}

// Helper widget untuk bagian administrasi pendaftaran
pw.Widget _buildAdministrationSection() {
  return pw.Container(
    height: 290,
    width: double.infinity,
    decoration: pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(width: 0.5),
      ),
    ),
    child: pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('DIISI OLEH ADMINISTRASI PENDAFTARAN'),
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
                  _buildCheckboxGroup(['Kartu Pendonor']),
                ],
              ),
              ...['KTP', 'SIM', 'Kartu Pelajar / Mahasiswa', 'Paspor'].map((item) => 
                pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 10),
                  child: pw.Row(
                    children: [
                      pw.Container(width: 180),
                      _buildCheckboxGroup([item]),
                    ],
                  ),
                ),
              ).toList(),
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

// Helper widget untuk bagian petugas aftap
pw.Widget _buildAftapSection() {
  return pw.Container(
    height: 400,
    width: double.infinity,
    child: pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('DIISI OLEH PETUGAS AFTAP'),
          pw.SizedBox(height: 10),
          _buildFormFieldWithDots('Nama Petugas Aftap'),
          pw.SizedBox(height: 10),
          pw.Row(
            children: [
              pw.Container(
                width: 196,
                child: pw.Text(
                  "Verifikasi Kantong Darah",
                  style: pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.Text(
                ' : ',
                style: pw.TextStyle(fontSize: 10),
              ),
              _buildCheckboxGroup(['Nomor Selang & Kantong Sesuai']),
            ],
          ),
          ...['Selang Kantong Tidak Terlipat', 'Kantong Tidak/Belum Kadaluwarsa', 'Jarum Tajam & Tertutup', 'Tidak Ada Tanda Kebocoran Kantong'].map((item) =>
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 10),
              child: pw.Row(
                children: [
                  pw.Container(width: 196),
                  pw.Text(
                    ' : ',
                    style: pw.TextStyle(fontSize: 10),
                  ),
                  _buildCheckboxGroup([item]),
                ],
              ),
            ),
          ).toList(),
          pw.SizedBox(height: 10),
          pw.Row(
            children: [
              pw.Container(
                width: 100,
                child: pw.Text(
                  "Pengambilan",
                  style: pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.Text(
                ' : ',
                style: pw.TextStyle(fontSize: 10),
              ),
              _buildCheckboxGroup(['Lancar', 'Tidak Lancar']),
              pw.SizedBox(width: 4),
              pw.Text(
                "Stop...........................cc",
                style: pw.TextStyle(fontSize: 10),
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            children: [
              pw.Container(
                width: 100,
                child: pw.Text(
                  "Reaksi Donor",
                  style: pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.Text(
                ' : ',
                style: pw.TextStyle(fontSize: 10),
              ),
              _buildCheckboxGroup(['Pusing', 'Muntah', 'Hematom']),
              pw.SizedBox(width: 4),
              pw.Text(
                "Lain-lain..................................",
                style: pw.TextStyle(fontSize: 10),
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            children: [
              pw.Container(
                width: 100,
                child: pw.Text(
                  "Jenis Kantong",
                  style: pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.Text(
                ' : ',
                style: pw.TextStyle(fontSize: 10),
              ),
              _buildCheckboxGroup(['Single', 'Double', 'Triple', 'Quadruple', 'Kit Apheresis']),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            children: [
              pw.Container(
                width: 100,
                child: pw.Text(
                  "Diambil",
                  style: pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.Text(
                ' : ',
                style: pw.TextStyle(fontSize: 10),
              ),
              _buildCheckboxGroup(['250 cc', '350 cc', '450 cc']),
              pw.SizedBox(width: 4),
              pw.Text(
                "............",
                style: pw.TextStyle(fontSize: 10),
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          _buildFormFieldWithDots('Jam Aftap', suffix: '............... : ...............    sd     ............... : ...............', showDots: false),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: 100,
                child: pw.Text(
                  "Nomor Kantong",
                  style: pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.Text(
                ' : ',
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.Container(
                width: 200,
                height: 80,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(width: 0.5),
                ),
              ),
              pw.Spacer(),
              _buildSignatureField('Tanda Tangan Petugas'),
            ],
          ),
        ],
      ),
    ),
  );
}
