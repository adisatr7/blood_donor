import 'package:blood_donor/models/db/questionnaire.dart';

final Questionnaire allQuestions = Questionnaire(
  sections: [
    QuestionnaireSection(
      title: 'Dalam hari ini',
      sectionNumber: 1,
      items: [
        QuestionnaireSectionItem(
          itemNumber: 1,
          question: 'Merasa sehat pada hari ini?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 2,
          question: 'Sedang minum antibiotik?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 3,
          question: 'Sedang minum obat lain untuk infeksi?',
        ),
      ],
    ),
    QuestionnaireSection(
      title: 'Dalam waktu 48 jam terakhir',
      sectionNumber: 2,
      items: [
        QuestionnaireSectionItem(
          itemNumber: 4,
          question:
              'Apakah Anda sedang minum aspirin atau obat yang mengandung aspirin?',
        ),
      ],
    ),
    QuestionnaireSection(
      title: 'Dalam waktu 1 minggu terakhir',
      sectionNumber: 3,
      items: [
        QuestionnaireSectionItem(
          itemNumber: 5,
          question: 'Apakah Anda mengalami sakit kepala dan demam bersamaan?',
        ),
      ],
    ),
    QuestionnaireSection(
      title: 'Dalam waktu 6 minggu terakhir',
      sectionNumber: 4,
      items: [
        QuestionnaireSectionItem(
          itemNumber: 6,
          question:
              'Untuk donor darah wanita: Apakah Anda saat ini sedang hamil?',
        ),
      ],
    ),
    QuestionnaireSection(
      title: 'Dalam waktu 8 minggu terakhir',
      sectionNumber: 5,
      items: [
        QuestionnaireSectionItem(
          itemNumber: 7,
          question: 'Apakah Anda mendonorkan darah lengkap?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 8,
          question: 'Apakah Anda menerima vaksinasi atau suntikan lainnya?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 9,
          question:
              'Apakah Anda pernah kontak dengan orang yang menerima vaksinasi smallpox/cacar air?',
        ),
      ],
    ),
    QuestionnaireSection(
      title: 'Dalam waktu 16 minggu terakhir',
      sectionNumber: 6,
      items: [
        QuestionnaireSectionItem(
          itemNumber: 10,
          question:
              'Apakah Anda mendonorkan 2 kantong sel darah merah melalui proses afereis?',
        ),
      ],
    ),
    QuestionnaireSection(
      title: 'Dalam waktu 6 bulan terakhir',
      sectionNumber: 7,
      items: [
        QuestionnaireSectionItem(
          itemNumber: 11,
          question: 'Apakah Anda pernah mengunjungi daerah endemis malaria?',
        ),
      ],
    ),
    QuestionnaireSection(
      title: 'Dalam waktu 12 bulan terakhir',
      sectionNumber: 8,
      items: [
        QuestionnaireSectionItem(
          itemNumber: 12,
          question: 'Apakah Anda pernah menerima tranfusi darah?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 13,
          question:
              'Apakah Anda pernah mendapat transplantasi, organ, atau jaringan sumsung tulang?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 14,
          question: 'Apakah Anda pernah cangkok organ?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 15,
          question: 'Apakah Anda pernah tertusuk jarum medis?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 16,
          question:
              'Apakah Anda pernah berhubungan seksual dengan orang dengan HIV/AIDS?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 17,
          question:
              'Apakah Anda pernah berhubungan seksual dengan pekerja seks komersil?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 18,
          question:
              'Apakah Anda pernah berhubungan seksual dengan pengguna narkotika jarum suntik?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 19,
          question:
              'Apakah Anda pernah berhubungan seksual dengan pengguna konsentrat faktor pembekuan?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 20,
          question:
              'Donor wanita: Apakah Anda pernah berhubungan seksual dengan laki-laki biseksual?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 21,
          question:
              'Apakah Anda pernah berhubungan seksual dengan orang yang terinfeksi hepatitis?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 22,
          question: 'Apakah Anda tinggal bersama penderita hepatitis?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 23,
          question: 'Apakah Anda memiliki tatto?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 24,
          question:
              'Apakah Anda memiliki tindik telinga atau bagian tubuh lainnya?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 25,
          question:
              'Apakah Anda sedang atau pernah mendapat pengobatan sifilis atau GO (kencing nanah)?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 26,
          question:
              'Apakah Anda pernah ditahan di penjara untuk waktu lebih dari 72 jam?',
        ),
      ],
    ),
    QuestionnaireSection(
      title: 'Dalam waktu 1 tahun',
      sectionNumber: 9,
      items: [
        QuestionnaireSectionItem(
          itemNumber: 27,
          question: 'Apakah Anda menetap di berbagai alamat yang berebda?',
        ),
      ],
    ),
    QuestionnaireSection(
      title: 'Dalam waktu 3 tahun',
      sectionNumber: 10,
      items: [
        QuestionnaireSectionItem(
          itemNumber: 28,
          question: 'Apakah Anda pernah berada di luar wilayah Indonesia?',
        ),
      ],
    ),
    QuestionnaireSection(
      title: 'Tahun 1980 hingga sekarang',
      sectionNumber: 11,
      items: [
        QuestionnaireSectionItem(
          itemNumber: 29,
          question: 'Apakah Anda tinggal selama 5 tahun atau lebih di Eropa?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 30,
          question: 'Apakah Anda menerima tranfusi darah di Inggris?',
        ),
      ],
    ),
    QuestionnaireSection(
      title: 'Tahun 1980 hingga 1996',
      sectionNumber: 12,
      items: [
        QuestionnaireSectionItem(
          itemNumber: 31,
          question: 'Apakah Anda tinggal selama 3 bulan atau lebih di Inggris?',
        ),
      ],
    ),
    QuestionnaireSection(
      title: 'Apakah Anda pernah',
      sectionNumber: 13,
      items: [
        QuestionnaireSectionItem(
          itemNumber: 32,
          question:
              'Apakah Anda menerima uang, obat, atau pembayaran lainnya untuk seks?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 33,
          question:
              'Laki-laki: Apakah Anda pernah berhubungan seksual dengan laki-laki, walaupun sekali?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 34,
          question: 'Mendapat hasil positif untuk tes HIV/AIDS?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 35,
          question: 'Apakah Anda pernah melakukan bekam/fasdhu?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 36,
          question:
              'Menggunakan jarum suntik untuk obat-obatan/steroid yang tidak diresepkan dokter?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 37,
          question: 'Menggunakan konsentrat faktor pembekuan?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 38,
          question: 'Menderita hepatitis?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 39,
          question: 'Menderita malaria?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 40,
          question: 'Menderita kanker termasuk leukimia?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 41,
          question: 'Bermasalah dengan jantung dan paru-paru?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 42,
          question:
              'Menderita pendarahan atau penyakit berhubungan dengan darah?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 43,
          question: 'Berhubungan dengan orang yang tinggal di Afrika?',
        ),
        QuestionnaireSectionItem(
          itemNumber: 44,
          question: 'Tinggal di Afrika?',
        ),
      ],
    ),
  ],
);
