import 'package:blood_donor/widgets/buttons/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/controllers/questionare_form_controller.dart';
import 'package:blood_donor/models/questionnaire.dart';
import 'package:blood_donor/widgets/scaffolds/app_scaffold.dart';
import 'package:blood_donor/core/theme.dart';
import 'package:blood_donor/widgets/inputs/select_input.dart';

class QuestionnaireFormView extends StatelessWidget {
  QuestionnaireFormView({super.key});

  final QuestionnaireFormController controller = Get.put(
    QuestionnaireFormController(),
  );

  Widget _buildSubsection(Questionnaire questioner) {
    List<QuestionnaireItem> items = questioner.items;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(questioner.title, style: AppTextStyles.subheading),
        ),
        ...items.map((item) => _buildItem(item)),
      ],
    );
  }

  Widget _buildItem(QuestionnaireItem item) {
    return SelectInput(
      label: '${item.itemNumber}. ${item.question}',
      options: controller.options,
      selectedValue: item.answer,
    );
  }

  @override
  Widget build(BuildContext context) {
    final int itemCount = controller.questionnaireForm.length;
    List<Questionnaire> q = controller.questionnaireForm;

    RxBool isAllAnswered = Questionnaire.isAllAnswered(q);

    return AppScaffold(
      title: 'Form Kuesioner',
      showBackButton: true,
      backButtonLabel: 'Batal Isi',
      footer: WideButton(label: 'Kirim', isDisabled: isAllAnswered),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) => _buildSubsection(q[index]),
      ),
    );
  }
}
