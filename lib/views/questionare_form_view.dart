import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/controllers/questionare_form_controller.dart';
import 'package:blood_donor/models/db/questionnaire.dart';
import 'package:blood_donor/core/theme.dart';
import 'package:blood_donor/widgets/scaffolds/app_scaffold.dart';
import 'package:blood_donor/widgets/inputs/select_input.dart';
import 'package:blood_donor/models/db/user.dart';
import 'package:blood_donor/widgets/buttons/wide_button.dart';
import 'package:intl/intl.dart';

class QuestionnaireFormView extends StatelessWidget {
  QuestionnaireFormView({super.key});

  final QuestionnaireFormController controller = Get.put(
    QuestionnaireFormController(),
  );

  /// Method builder untuk menampilkan field data diri
  Widget _buildFieldsText(String field, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: '$field: ', style: AppTextStyles.bodyBold),
          TextSpan(text: value, style: AppTextStyles.body),
        ],
      ),
    );
  }

  /// Method builder untuk setiap bab kuesioner yang di
  /// dalamnya berisi banyak item-item pertanyaan
  Widget _buildSection(QuestionnaireSection section) {
    List<QuestionnaireSectionItem> items = section.items;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            section.title,
            style: AppTextStyles.subheadingBold,
          ), // Judul bab
        ),
        ...items.map(
          (item) => _buildItem(item),
        ), // Daftar semua pertanyaan dalam bab ini
      ],
    );
  }

  /// Method builder untuk setiap item pertanyaan
  Widget _buildItem(QuestionnaireSectionItem item) {
    return SelectInput(
      label: '${item.itemNumber}. ${item.question}',
      options: controller.options,
      selectedValue: item.answer,
      onChanged: controller.validateAnswers,
    );
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd/MM/yyyy', 'id');

    // Ambil data user dan nama lokasi agar kode tidak terlalu panjang
    final User userData = controller.global.currentUser.value!;
    final String locationName = controller.selectedLocation.name;

    // Ambil semua bab kuesioner
    final List<QuestionnaireSection> sections =
        controller.allQuestionnaireSections;

    return AppScaffold(
      title: 'Form Kuesioner',
      showBackButton: true,
      backButtonLabel: 'Batal Isi',
      footer: WideButton(
        label: 'Kirim',
        onPressed: controller.handleSubmit,
        isLoading: controller.isLoading,
        isDisabled: controller.isSubmitDisabled,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Data Diri Anda', style: AppTextStyles.subheadingBold),
          const SizedBox(height: 6),

          // Tampilkan data diri berdasarkan profil user
          // Dibungkus oleh Column agar rapi saja
          Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pastikan data berikut sudah tepat:',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 2),

              _buildFieldsText('Lokasi Terpilih', locationName),
              _buildFieldsText('NIK', userData.nik),
              _buildFieldsText('Nama Lengkap', userData.name),
              _buildFieldsText('TTL', '${userData.birthPlace}, ${formatter.format(userData.birthDate)}'),
              _buildFieldsText('Umur', '${DateTime.now().year - userData.birthDate.year} tahun'),
              _buildFieldsText('Jenis Kelamin', userData.gender),
              const SizedBox(height: 6),

              _buildFieldsText('Pekerjaan', userData.job),
              _buildFieldsText('Alamat', userData.address),
              _buildFieldsText('Kel/Kec', '${userData.village}/${userData.district}'),
              _buildFieldsText('Wilayah', userData.city),
            ],
          ),
          const SizedBox(height: 12),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sections.length,
            itemBuilder: (context, index) => _buildSection(sections[index]),
          ),
        ],
      ),
    );
  }
}
