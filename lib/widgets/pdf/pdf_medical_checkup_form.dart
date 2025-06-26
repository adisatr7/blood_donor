import 'package:pdf/widgets.dart' as pw;

import 'package:blood_donor/widgets/pdf/pdf_form_header.dart';
import 'package:blood_donor/widgets/pdf/pdf_checkbox_group.dart';
import 'package:blood_donor/widgets/pdf/pdf_form_field.dart';
import 'package:blood_donor/widgets/pdf/pdf_signature_field.dart';

pw.Widget buildPdfMedicalCheckupForm() {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      buildPdfFormHeader(title: 'DIISI OLEH PETUGAS MEDICAL CHECKUP'),
      pw.SizedBox(height: 10),
      pw.Row(
        children: [
          pw.SizedBox(
            width: 120,
            child: pw.Text('Jenis Donor', style: pw.TextStyle(fontSize: 10)),
          ),
          pw.Text(': ', style: pw.TextStyle(fontSize: 10)),
          buildPdfCheckboxGroup(labels: ['Sukarela', 'Pengganti']),
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
          pw.Text(': ', style: pw.TextStyle(fontSize: 10)),
          buildPdfCheckboxGroup(labels: ['Biasa', 'Apheresis', 'Autologus']),
        ],
      ),
      pw.SizedBox(height: 10),
      pw.Row(
        children: [
          pw.SizedBox(
            width: 120,
            child: pw.Text('Golongan Darah', style: pw.TextStyle(fontSize: 10)),
          ),
          pw.Text(': ', style: pw.TextStyle(fontSize: 10)),
          buildPdfCheckboxGroup(labels: ['A', 'B', 'AB', 'O']),
        ],
      ),
      pw.SizedBox(height: 10),
      pw.Row(
        children: [
          pw.SizedBox(
            width: 120,
            child: pw.Text('Rhesus Darah', style: pw.TextStyle(fontSize: 10)),
          ),
          pw.Text(': ', style: pw.TextStyle(fontSize: 10)),
          buildPdfCheckboxGroup(labels: ['Positif', 'Negatif']),
        ],
      ),
      pw.SizedBox(height: 10),
      buildPdfField(label: 'Berat Badan', value: 'Kg', showDots: true),
      pw.SizedBox(height: 10),
      buildPdfField(label: 'Tinggi Badan', value: 'cm', showDots: true),
      pw.SizedBox(height: 10),
      buildPdfField(label: 'Nilai Hemoglobin', value: 'g/dL', showDots: true),
      pw.SizedBox(height: 10),
      buildPdfField(label: 'Tekanan Darah', value: 'mmHg', showDots: true),
      pw.SizedBox(height: 10),
      buildPdfField(label: 'Denyut Nadi', value: 'x/menit', showDots: true),
      pw.SizedBox(height: 10),
      buildPdfField(label: 'Suhu', value: '°C', showDots: true),
      pw.SizedBox(height: 10),
      buildPdfField(label: 'Riwayat Medis', showDots: true),
      pw.SizedBox(height: 10),
      buildPdfField(label: 'Keadaan Umum', showDots: true),
      pw.SizedBox(height: 10),
      pw.Row(
        children: [
          pw.SizedBox(
            width: 120,
            child: pw.Text('Status', style: pw.TextStyle(fontSize: 10)),
          ),
          pw.Text(': ', style: pw.TextStyle(fontSize: 10)),
          buildPdfCheckboxGroup(labels: ['Diterima', 'Ditolak']),
        ],
      ),
      pw.SizedBox(height: 50),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          buildPdfSignatureField(label: 'Keterangan (jika ada)'),
          buildPdfSignatureField(label: 'Tanda Tangan Petugas'),
        ],
      ),
    ],
  );
}
