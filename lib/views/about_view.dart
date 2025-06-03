import 'package:flutter/material.dart';

import 'package:blood_donor/widgets/scaffolds/app_scaffold.dart';
import 'package:blood_donor/core/theme.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Sejarah PMI', style: AppTextStyles.headingBold),
          const SizedBox(height: 12),

          // TODO: Tambahkan gambar/logo PMI di sini (jika ada)
          const Text(
            'Palang Merah Indonesia sebenarnya dimulai sebelum Perang Dunia II. '
            'Pada 21 Oktober 1873, Pemerintah Kolonial Belanda mendirikan Palang '
            'Merah di Indonesia dengan nama Nederlands Rode Kruis Afdeling Indie '
            '(Nerkai). Namun, organisasi ini kemudian dibubarkan selama '
            'pendudukan Jepang.',
            style: AppTextStyles.body,
          ),
          const SizedBox(height: 10),

          const Text(
            'Perjuangan untuk mendirikan Palang Merah Indonesia dimulai sekitar '
            'tahun 1932, dipelopori oleh Dr. RCL Senduk dan Dr. Bahder Djohan. '
            'Inisiatif ini mendapatkan dukungan luas, terutama dari kalangan '
            'terpelajar Indonesia. Meskipun mereka berusaha menyampaikan '
            'proposal tersebut pada Konferensi Nerkai tahun 1940, proposal itu '
            'ditolak mentah-mentah. Tanpa menyerah, rencana itu sementara '
            'diabaikan, menunggu kesempatan yang tepat.',
            style: AppTextStyles.body,
          ),
          const SizedBox(height: 10),

          const Text(
            'Selama pendudukan Jepang, mereka mencoba sekali lagi untuk membentuk '
            'Badan Palang Merah Nasional, tetapi usaha ini kembali digagalkan oleh '
            'pemerintah militer Jepang, memaksa proposal tersebut untuk disimpan '
            'kembali untuk kedua kalinya.',
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }
}
