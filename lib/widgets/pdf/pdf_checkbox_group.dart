import 'package:pdf/widgets.dart' as pw;

import 'package:blood_donor/widgets/pdf/pdf_labeled_checkbox.dart';

pw.Widget buildPdfCheckboxGroup({
  required List<String> labels,
  double spacing = 10.0,
}) {
  return pw.Row(
    children:
        labels
            .expand(
              (text) => [
                buildPdfLabeledCheckbox(label: text),
                pw.SizedBox(width: spacing),
              ],
            )
            .toList()
          ..removeLast(),
  );
}
