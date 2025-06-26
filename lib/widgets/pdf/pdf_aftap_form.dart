import 'package:pdf/widgets.dart' as pw;

import 'package:blood_donor/widgets/pdf/pdf_form_header.dart';
import 'package:blood_donor/widgets/pdf/pdf_form_field.dart';
import 'package:blood_donor/widgets/pdf/pdf_checkbox_group.dart';
import 'package:blood_donor/widgets/pdf/pdf_signature_field.dart';

pw.Widget buildPdfAftapForm() {
  final List<String> options = [
    'Selang Kantong Tidak Terlipat',
    'Kantong Tidak/Belum Kadaluwarsa',
    'Jarum Tajam & Tertutup',
    'Tidak Ada Tanda Kebocoran Kantong',
  ];

  return pw.Container(
    height: 400,
    width: double.infinity,
    child: pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          buildPdfFormHeader(title: 'DIISI OLEH PETUGAS AFTAP'),
          pw.SizedBox(height: 10),

          buildPdfField(label: 'Nama Petugas Aftap', showDots: true),
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
              pw.Text(' : ', style: pw.TextStyle(fontSize: 10)),
              buildPdfCheckboxGroup(labels: ['Nomor Selang & Kantong Sesuai']),
            ],
          ),

          ...options.map(
            (item) => pw.Padding(
              padding: const pw.EdgeInsets.only(top: 10),
              child: pw.Row(
                children: [
                  pw.Container(width: 196),
                  pw.Text(' : ', style: pw.TextStyle(fontSize: 10)),
                  buildPdfCheckboxGroup(labels: [item]),
                ],
              ),
            ),
          ),
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
              pw.Text(' : ', style: pw.TextStyle(fontSize: 10)),
              buildPdfCheckboxGroup(labels: ['Lancar', 'Tidak Lancar']),
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
              pw.Text(' : ', style: pw.TextStyle(fontSize: 10)),
              buildPdfCheckboxGroup(labels: ['Pusing', 'Muntah', 'Hematom']),
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
              pw.Text(' : ', style: pw.TextStyle(fontSize: 10)),
              buildPdfCheckboxGroup(
                labels: [
                  'Single',
                  'Double',
                  'Triple',
                  'Quadruple',
                  'Kit Apheresis',
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            children: [
              pw.Container(
                width: 100,
                child: pw.Text("Diambil", style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Text(' : ', style: pw.TextStyle(fontSize: 10)),
              buildPdfCheckboxGroup(labels: ['250 cc', '350 cc', '450 cc']),
              pw.SizedBox(width: 4),
              pw.Text("............", style: pw.TextStyle(fontSize: 10)),
            ],
          ),
          pw.SizedBox(height: 10),
          buildPdfField(
            label: 'Jam Aftap',
            value:
                '............... : ...............    sd     ............... : ...............',
            showDots: false,
          ),
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
              pw.Text(' : ', style: pw.TextStyle(fontSize: 10)),
              pw.Container(
                width: 200,
                height: 80,
                decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.5)),
              ),
              pw.Spacer(),
              buildPdfSignatureField(label: 'Tanda Tangan Petugas'),
            ],
          ),
        ],
      ),
    ),
  );
}
