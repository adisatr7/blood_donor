import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

import 'package:blood_donor/controllers/pdf_print_controller.dart';
import 'package:blood_donor/models/db/user.dart';
import 'package:blood_donor/models/db/appointment.dart';
import 'package:blood_donor/widgets/pdf/pdf_location_date_section.dart';
import 'package:blood_donor/widgets/pdf/pdf_page_header.dart';
import 'package:blood_donor/widgets/pdf/pdf_form_field.dart';
import 'package:blood_donor/widgets/pdf/pdf_checkbox_group.dart';
import 'package:blood_donor/constants/questionnaire_list.dart';
import 'package:blood_donor/widgets/pdf/pdf_question_table.dart';
import 'package:blood_donor/widgets/pdf/pdf_administration_form.dart';
import 'package:blood_donor/widgets/pdf/pdf_aftap_form.dart';
import 'package:blood_donor/widgets/pdf/pdf_medical_checkup_form.dart';

class PdfPrintView extends StatelessWidget {
  final PdfPrintController controller = Get.put(PdfPrintController());

  PdfPrintView({super.key});

  /// Method getter internal untuk mengambil TTL user
  String get _userBirthDate {
    final DateFormat formatter = DateFormat('dd/MM/yyyy', 'id');
    final user = controller.global.currentUser.value!;

    return '${user.birthPlace}, ${formatter.format(user.birthDate)}';
  }

  /// Method getter internal untuk menghitung umur user
  String get _userAge {
    final now = DateTime.now();

    final user = controller.global.currentUser.value!;
    final age = now.year - user.birthDate.year;

    final isBirthdayPassed =
        now.month > user.birthDate.month ||
        (now.month == user.birthDate.month && now.day >= user.birthDate.day);

    final adjustedAge = isBirthdayPassed ? age : age - 1;

    return '$adjustedAge tahun';
  }

  /// Method getter internal untuk mendapatkan nomor kartu donor
  /// Nomor ini diisi dengan ID user yang dipadankan dengan 16 digit
  /// dengan menambahkan nol di depan jika kurang dari 16 digit
  String get _donorCardNumber {
    return controller.global.currentUser.value!.id.toString().padLeft(16, '0');
  }

  /// Method builder untuk subheader halaman pertama
  pw.Widget _buildPageOneSubheader() {
    return pw.Column(
      children: [
        pw.Text(
          'Selamat Datang, Terima Kasih Atas Kesediaan Anda Meluangkan Waktu Untuk Menyumbangkan Darah',
          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          'Mohon Formulir ini Diisi Dengan Sejujurnya Untuk Keselamatan Anda dan Calon Penerima Darah Anda',
          style: pw.TextStyle(fontSize: 10),
        ),
      ],
    );
  }

  /// Method builder untuk subheader halaman kedua
  pw.Widget _buildPageTwoSubheader() {
    return pw.Text(
      'MOHON DIISI LENGKAP MENGGUNAKAN HURUF KAPITAL',
      style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lembar Formulir Donor Darah'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: FutureBuilder<Uint8List>(
        future: rootBundle
            .load('assets/icons/check.png')
            .then((b) => b.buffer.asUint8List()),
        builder: (context, snapshot) {
          final PdfPageFormat f4PageFormat = PdfPageFormat(210 * PdfPageFormat.mm, 330 * PdfPageFormat.mm);

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final checkIcon = pw.MemoryImage(snapshot.data!);

          return Obx(() {
            if (controller.appointment.value == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final User user = controller.global.currentUser.value!;
            final Appointment appointment = controller.appointment.value!;
            final List<AppointmentQuestionnaire> allAnswers =
                appointment.questionnaire;

            return PdfPreview(
              initialPageFormat: f4PageFormat,
              maxPageWidth: 1200,
              build: (format) async {
                final pdfFile = pw.Document();

                // Halaman Pertama
                pdfFile.addPage(
                  pw.Page(
                    pageFormat: f4PageFormat,
                    margin: const pw.EdgeInsets.all(24),
                    build: (context) {
                      return pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          // Header halaman 1
                          buildPdfPageHeader(
                            pageNumber: 1,
                            subheader: _buildPageOneSubheader(),
                          ),
                          pw.SizedBox(height: 16),

                          // Tempat & tanggal donor
                          buildPdfLocationDateSection(
                            location: appointment.location.name,
                            date: appointment.location.time.end,
                          ),
                          pw.SizedBox(height: 8),

                          // Biodata Pendonor
                          pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            // Bagian biodata dibagi menjadi 2 kolom
                            child: pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                // (<-) Kolom Kiri
                                pw.Expanded(
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      buildPdfField(
                                        label: 'No. KTP / Paspor (WNA)',
                                        value: user.nik,
                                        labelWidth: 150,
                                      ),
                                      buildPdfField(
                                        label: 'Nama Lengkap',
                                        value: user.name,
                                        labelWidth: 150,
                                      ),
                                      buildPdfField(
                                        label: 'Tempat, Tanggal Lahir',
                                        value: _userBirthDate,
                                        labelWidth: 150,
                                      ),
                                      buildPdfField(
                                        label: 'Umur',
                                        value: _userAge,
                                        labelWidth: 150,
                                      ),
                                      buildPdfField(
                                        label: 'Jenis Kelamin',
                                        value: user.gender,
                                        labelWidth: 150,
                                      ),
                                      pw.SizedBox(height: 4),

                                      // Penghargaan
                                      pw.Row(
                                        children: [
                                          pw.Text(
                                            'Penghargaan yang telah diterima: ',
                                            style: pw.TextStyle(fontSize: 10),
                                          ),
                                          buildPdfCheckboxGroup(
                                            labels: [
                                              '10x',
                                              '25x',
                                              '50x',
                                              '75x',
                                              '100x',
                                            ],
                                          ),
                                        ],
                                      ),
                                      pw.SizedBox(height: 4),

                                      // Pertanyaan persetujuan (1)
                                      pw.Row(
                                        children: [
                                          pw.Text(
                                            'Bersediakah saudara donor pada waktu bulan puasa: ',
                                            style: pw.TextStyle(fontSize: 10),
                                          ),
                                          buildPdfCheckboxGroup(
                                            labels: ['Ya', 'Tidak'],
                                          ),
                                        ],
                                      ),
                                      pw.SizedBox(height: 4),

                                      // Pertanyaan persetujuan (2)
                                      pw.Row(
                                        children: [
                                          pw.Text(
                                            'Bersediakah saudara donor saat dibutuhkan untuk komponen darah tertentu: ',
                                            style: pw.TextStyle(fontSize: 10),
                                          ),
                                          buildPdfCheckboxGroup(
                                            labels: ['Ya', 'Tidak'],
                                          ),
                                        ],
                                      ),
                                      pw.SizedBox(height: 4),

                                      // Terakhir kali donor
                                      pw.Text(
                                        'Donor yang terakhir tanggal:................................................ sekarang donor yang ke : 15 kali',
                                        style: pw.TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),

                                // (->) Kolom Kanan
                                pw.Expanded(
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      buildPdfField(
                                        label: 'No. Kartu Donor',
                                        value: _donorCardNumber,
                                      ),
                                      buildPdfField(
                                        label: 'Pekerjaan',
                                        value: user.job,
                                      ),
                                      buildPdfField(
                                        label: 'Alamat',
                                        value: user.address,
                                      ),
                                      buildPdfField(
                                        label: 'Kel. / Kec.',
                                        value: user.district,
                                      ),
                                      buildPdfField(
                                        label: 'Wilayah',
                                        value: user.city,
                                      ),
                                      buildPdfField(
                                        label: 'No. HP',
                                        value: user.phoneNumber,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.SizedBox(height: 8),

                          // Instruksi Kuesioner
                          pw.Row(
                            children: [
                              // Ini nantinya jadi 1 kalimat utuh dalam satu baris
                              // Kode ditulis terpisah karena ada icon centang di tengah
                              pw.Text(
                                'Pilih dan Lengkapi Jawaban Anda dengan Tanda ',
                                style: pw.TextStyle(fontSize: 10),
                              ),
                              pw.Image(checkIcon, width: 11, height: 11),
                              pw.Text(
                                ' atau Tidak',
                                style: pw.TextStyle(fontSize: 8),
                              ),
                            ],
                          ),
                          pw.SizedBox(height: 4),

                          // Tabel Jawaban Kuesioner (bagi data menjadi 2 kolom sejajar)
                          pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              // (<-) Kolom Kiri
                              pw.Expanded(
                                child: pw.Padding(
                                  padding: const pw.EdgeInsets.only(right: 5),
                                  child: buildPdfQuestionTable(
                                    sections: allQuestions.sections,
                                    answers: allAnswers,
                                    checkIcon: checkIcon,
                                    isLeftColumn: true,
                                  ),
                                ),
                              ),

                              // (->) Kolom Kanan
                              pw.Expanded(
                                child: pw.Padding(
                                  padding: const pw.EdgeInsets.only(left: 5),
                                  child: buildPdfQuestionTable(
                                    sections: allQuestions.sections,
                                    answers: allAnswers,
                                    checkIcon: checkIcon,
                                    isLeftColumn: false,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          pw.SizedBox(height: 12),

                          // Teks persetujuan
                          pw.SizedBox(
                            width: 700,
                            child: pw.Text(
                              'Saya telah mendapatkan dan membaca semua informasi yang diberikan serta menjawab '
                              'pertanyaan dengan jujur. Saya mengerti dan bersedia menyumbangkan darah dengan '
                              'volume sesuai standar yang diberlakukan dan setuju diambil contoh darahnya untuk '
                              'keperluan pemeriksaan laboratorium berupa uji darah, HIV, Hepatitis B, Hepatitis '
                              'C, Sifilis, dan infeksi lainnya yang diperlukan serta untuk kepentingan penelitian. '
                              'Bila ternyata hasil pemeriksaan laboratorium perlu ditindaklanjuti, maka saya '
                              'setuju untuk diberi kabar tertulis. Jika komponen plasma tidak terpakai untuk '
                              'transfusi, saya setuju dapat dijadikan produk plasma untuk pengobatan.',
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
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
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
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
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
                pdfFile.addPage(
                  pw.Page(
                    pageFormat: f4PageFormat,
                    margin: const pw.EdgeInsets.all(24),
                    build: (context) {
                      return pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          // Header halaman 2
                          buildPdfPageHeader(
                            pageNumber: 2,
                            subheader: _buildPageTwoSubheader(),
                          ),
                          pw.SizedBox(height: 8),

                          // Tempat & tanggal donor
                          buildPdfLocationDateSection(
                            location: appointment.location.name,
                            date: appointment.location.time.end,
                          ),
                          pw.SizedBox(height: 8),

                          // Halaman 2 berisi 3 bagian. Form administrasi dan AFTAP
                          // di sebelah kiri sedangkan form pemeriksaan kesehatan
                          // di sebelah kanan
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
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        buildPdfAdministrationForm(),
                                        buildPdfAftapForm(),
                                      ],
                                    ),
                                  ),
                                  // Kolom Kanan (1 bagian)
                                  pw.Container(
                                    height: 600,
                                    child: pw.Padding(
                                      padding: const pw.EdgeInsets.all(8),
                                      child: buildPdfMedicalCheckupForm(),
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

                return pdfFile.save();
              },
            );
          });
        },
      ),
    );
  }
}
