import 'package:blood_donor/models/questionnaire.dart';

List<Questionnaire> questionnaires = [
  Questionnaire(
    title: 'Dalam hari ini',
    sectionNumber: 1,
    items: [
      QuestionnaireItem(itemNumber: 1, question: 'Merasa sehat pada hari ini?'),
      QuestionnaireItem(itemNumber: 2, question: 'Sedang minum antibiotik?'),
      QuestionnaireItem(
        itemNumber: 3,
        question: 'Sedang minum obat lain untuk infeksi?',
      ),
    ],
  ),
  Questionnaire(
    title: 'Dalam waktu 48 jam terakhir',
    sectionNumber: 2,
    items: [
      QuestionnaireItem(
        itemNumber: 4,
        question:
            'Apakah anda sedang minum aspirin atau obat yang mengandung aspirin?',
      ),
    ],
  ),
  Questionnaire(
    title: 'Dalam waktu 1 minggu terakhir',
    sectionNumber: 3,
    items: [
      QuestionnaireItem(
        itemNumber: 5,
        question: 'Apakah anda mengalami sakit kepala dan demam bersamaan?',
      ),
    ],
  ),
  Questionnaire(
    title: 'Dalam waktu 6 minggu terakhir',
    sectionNumber: 4,
    items: [
      QuestionnaireItem(
        itemNumber: 6,
        question:
            'Untuk donor darah wanita: Apakah anda saat ini sedang hamil?',
      ),
    ],
  ),
  Questionnaire(
    title: 'Dalam waktu 8 minggu terakhir',
    sectionNumber: 5,
    items: [
      QuestionnaireItem(
        itemNumber: 7,
        question: 'Apakah anda mendonorkan darah lengkap?',
      ),
      QuestionnaireItem(
        itemNumber: 8,
        question: 'Apakah anda menerima vaksinasi atau suntikan lainnya?',
      ),
      QuestionnaireItem(
        itemNumber: 9,
        question:
            'Apakah anda pernah kontak dengan orang yang menerima vaksinasi smallpox/cacar air?',
      ),
    ],
  ),
  Questionnaire(
    title: 'Dalam waktu 16 minggu terakhir',
    sectionNumber: 6,
    items: [
      QuestionnaireItem(
        itemNumber: 10,
        question:
            'Apakah anda mendonorkan 2 kantong sel darah merah memlalui proses afereis?',
      ),
    ],
  ),
  Questionnaire(
    title: 'Dalam waktu 6 bulan terakhir',
    sectionNumber: 7,
    items: [
      QuestionnaireItem(
        itemNumber: 11,
        question: 'Apakah anda pernah mengunjungi daerah endemis malaria?',
      ),
    ],
  ),
  Questionnaire(
    title: 'Dalam waktu 12 bulan terakhir',
    sectionNumber: 8,
    items: [
      QuestionnaireItem(
        itemNumber: 12,
        question: 'Apakah anda pernah menerima tranfusi darah?',
      ),
      QuestionnaireItem(
        itemNumber: 13,
        question:
            'Apakah anda pernah mendapat transplantasi, organ, atau jaringan sumsung tulang?',
      ),
      QuestionnaireItem(
        itemNumber: 14,
        question: 'Apakah anda pernah cangkok organ?',
      ),
      QuestionnaireItem(
        itemNumber: 15,
        question: 'Apakah anda pernah tertusuk jarum medis?',
      ),
      QuestionnaireItem(
        itemNumber: 16,
        question:
            'Apakah anda pernah berhubungan seksual dengan orang dengan HIV/AIDS?',
      ),
      QuestionnaireItem(
        itemNumber: 17,
        question:
            'Apakah anda pernah berhubungan seksual dengan pekerja seks komersil?',
      ),
      QuestionnaireItem(
        itemNumber: 18,
        question:
            'Apakah anda pernah berhubungan seksual dengan pengguna narkotika jarum suntik?',
      ),
      QuestionnaireItem(
        itemNumber: 19,
        question:
            'Apakah anda pernah berhubungan seksual dengan pengguna konsentrat faktor pembekuan?',
      ),
      QuestionnaireItem(
        itemNumber: 20,
        question:
            'Donor wanita: Apakah anda pernah berhubungan seksual dengan laki-laki biseksual?',
      ),
      QuestionnaireItem(
        itemNumber: 21,
        question:
            'Apakah anda pernah berhubungan seksual dengan orang yang terinfeksi hepatitis?',
      ),
      QuestionnaireItem(
        itemNumber: 22,
        question: 'Apakah anda tinggal bersama penderita hepatitis?',
      ),
      QuestionnaireItem(
        itemNumber: 23,
        question: 'Apakah anda memiliki tatto?',
      ),
      QuestionnaireItem(
        itemNumber: 24,
        question:
            'Apakah anda memiliki tindik telinga atau bagian tubuh lainnya?',
      ),
      QuestionnaireItem(
        itemNumber: 25,
        question:
            'Apakah anda sedang atau pernah mendapat pengobatan sifilis atau GO (kencing nanah)?',
      ),
      QuestionnaireItem(
        itemNumber: 26,
        question:
            'Apakah anda pernah ditahan di penjara untuk waktu lebih dari 72 jam?',
      ),
    ],
  ),
  Questionnaire(
    title: 'Dalam waktu 1 tahun',
    sectionNumber: 9,
    items: [
      QuestionnaireItem(
        itemNumber: 27,
        question: 'Apakah anda menetap di berbagai alamat yang berebda?',
      ),
    ],
  ),
  Questionnaire(
    title: 'Dalam waktu 3 tahun',
    sectionNumber: 10,
    items: [
      QuestionnaireItem(
        itemNumber: 28,
        question: 'Apakah anda pernah berada di luar wilayah Indonesia?',
      ),
    ],
  ),
  Questionnaire(
    title: 'Tahun 1980 hingga sekarang',
    sectionNumber: 11,
    items: [
      QuestionnaireItem(
        itemNumber: 29,
        question: 'Apakah anda tinggal selama 5 tahun atau lebih di Eropa?',
      ),
      QuestionnaireItem(
        itemNumber: 30,
        question: 'Apakah anda menerima tranfusi darah di Inggris?',
      ),
    ],
  ),
  Questionnaire(
    title: 'Tahun 1980 hingga 1996',
    sectionNumber: 12,
    items: [
      QuestionnaireItem(
        itemNumber: 31,
        question: 'Apakah anda tinggal selama 3 bulan atau lebih di Inggris?',
      ),
    ],
  ),
  Questionnaire(
    title: 'Apakah anda pernah',
    sectionNumber: 13,
    items: [
      QuestionnaireItem(
        itemNumber: 32,
        question:
            'Apakah anda menerima uang, obat, atau pembayaran lainnya untuk seks?',
      ),
      QuestionnaireItem(
        itemNumber: 33,
        question:
            'Laki-laki: Apakah anda pernah berhubungan seksual dengan laki-laki, walaupun sekali?',
      ),
      QuestionnaireItem(
        itemNumber: 34,
        question: 'Mendapat hasil positif untuk tes HIV/AIDS?',
      ),
      QuestionnaireItem(
        itemNumber: 35,
        question: 'Apakah anda pernah melakukan bekam/fasdhu?',
      ),
      QuestionnaireItem(
        itemNumber: 36,
        question:
            'Menggunakan jarum suntik untuk obat-obatan/steroid yang tidak diresepkan dokter?',
      ),
      QuestionnaireItem(
        itemNumber: 37,
        question: 'Menggunakan konsentrat faktor pembekuan?',
      ),
      QuestionnaireItem(itemNumber: 38, question: 'Menderita hepatitis?'),
      QuestionnaireItem(itemNumber: 39, question: 'Menderita malaria?'),
      QuestionnaireItem(
        itemNumber: 40,
        question: 'Menderita kanker termasuk leukimia?',
      ),
      QuestionnaireItem(
        itemNumber: 41,
        question: 'Bermasalah dengan jantung dan paru-paru?',
      ),
      QuestionnaireItem(
        itemNumber: 42,
        question:
            'Menderita pendarahan atau penyakit berhubungan dengan darah?',
      ),
      QuestionnaireItem(
        itemNumber: 43,
        question: 'Berhubungan dengan orang yang tinggal di Afrika?',
      ),
      QuestionnaireItem(itemNumber: 44, question: 'Tinggal di Afrika?'),
    ],
  ),
];
